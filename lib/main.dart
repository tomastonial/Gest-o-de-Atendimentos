import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'dart:io';
import 'package:image_picker/image_picker.dart';

import 'core/injectable.dart';
import 'module/atendimento/infra/controller/atendimento_controller.dart';
import 'module/atendimento/state/atendimento_state.dart';
import 'module/atendimento/core/domain/model/atendimento.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Atendimentos',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
      home: BlocProvider(
        create: (_) => getIt<AtendimentoController>()..carregarAtendimentos(),
        child: const AtendimentoHomePage(),
      ),
    );
  }
}

class AtendimentoHomePage extends StatefulWidget {
  const AtendimentoHomePage({super.key});

  @override
  State<AtendimentoHomePage> createState() => _AtendimentoHomePageState();
}

class _AtendimentoHomePageState extends State<AtendimentoHomePage> {
  bool _somenteAtivos = false;

  final ImagePicker _picker = ImagePicker();
  String? _fotoTemp;

  @override
  Widget build(BuildContext context) {
    final controller = context.read<AtendimentoController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Atendimentos'),
        actions: [
          Row(
            children: [
              const Text('Somente ativos'),
              Switch(
                value: _somenteAtivos,
                onChanged: (value) {
                  setState(() => _somenteAtivos = value);
                  if (value) {
                    controller.filtrarAtivos(true);
                  } else {
                    controller.carregarAtendimentos();
                  }
                },
              ),
              const SizedBox(width: 8),
            ],
          ),
        ],
      ),
      body: BlocBuilder<AtendimentoController, AtendimentoState>(
        builder: (context, state) {
          if (state is AtendimentoLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }

          List<Atendimento> lista = [];

          if (state is AtendimentoLoadedState) {
            lista = state.atendimentos;
          } else if (state is AtendimentoFilteredState) {
            lista = state.atendimentos;
          }

          if (lista.isEmpty) {
            return const Center(child: Text('Nenhum atendimento cadastrado.'));
          }

          return ListView.separated(
            itemCount: lista.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final it = lista[index];

              return ListTile(
                title: Text(it.nome),
                subtitle: Text(
                  [
                    if (it.descricao != null && it.descricao!.isNotEmpty)
                      it.descricao!,
                    'Preço: R\$ ${it.preco.toStringAsFixed(2)}',
                    if (it.data != null) 'Data: ${it.data}',
                  ].join(' • '),
                ),
                leading: Checkbox(
                  value: it.ativo,
                  onChanged: (value) {
                    if (value == null) return;
                    controller.alterarAtivo(it.id, value);
                  },
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      tooltip: 'Editar',
                      icon: const Icon(Icons.edit),
                      onPressed: () => _abrirFormAtendimento(context, it),
                    ),
                    IconButton(
                      tooltip: 'Excluir',
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () async {
                        final confirmar = await showDialog<bool>(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: const Text('Excluir atendimento'),
                            content: Text(
                              'Tem certeza que deseja excluir "${it.nome}"?',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(ctx, false),
                                child: const Text('Cancelar'),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(ctx, true),
                                child: const Text(
                                  'Excluir',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ],
                          ),
                        );

                        if (confirmar == true) {
                          await controller.excluirAtendimento(it.id);
                        }
                      },
                    ),
                  ],
                ),
                onTap: () => _abrirFormAtendimento(context, it),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _abrirFormAtendimento(context, null),
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _abrirFormAtendimento(
    BuildContext context,
    Atendimento? atendimento,
  ) async {
    final controller = context.read<AtendimentoController>();

    final nomeCtrl = TextEditingController(text: atendimento?.nome ?? '');
    final descCtrl = TextEditingController(text: atendimento?.descricao ?? '');
    final precoCtrl = TextEditingController(
      text: atendimento != null ? atendimento.preco.toString() : '',
    );
    bool ativo = atendimento?.ativo ?? true;

    _fotoTemp = atendimento?.foto;

    await showDialog<void>(
      context: context,
      builder: (dialogCtx) {
        return StatefulBuilder(
          builder: (ctx, setStateDialog) {
            return AlertDialog(
              title: Text(
                atendimento == null ? 'Novo atendimento' : 'Editar atendimento',
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: nomeCtrl,
                      decoration: const InputDecoration(labelText: 'Nome'),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: descCtrl,
                      decoration: const InputDecoration(labelText: 'Descrição'),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: precoCtrl,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      decoration: const InputDecoration(labelText: 'Preço'),
                    ),
                    const SizedBox(height: 8),

                    if (_fotoTemp != null) ...[
                      SizedBox(
                        height: 150,
                        child: Image.file(File(_fotoTemp!), fit: BoxFit.cover),
                      ),
                      const SizedBox(height: 8),
                    ],

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () async {
                              final XFile? imagem = await _picker.pickImage(
                                source: ImageSource.gallery,
                                maxWidth: 1024,
                                imageQuality: 85,
                              );

                              if (imagem != null) {
                                _fotoTemp = imagem.path;
                                setStateDialog(() {});
                              }
                            },
                            icon: const Icon(Icons.photo),
                            label: Text(
                              _fotoTemp == null
                                  ? 'Galeria'
                                  : 'Trocar (galeria)',
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () async {
                              final XFile? foto = await _picker.pickImage(
                                source: ImageSource.camera,
                                maxWidth: 1024,
                                imageQuality: 85,
                              );

                              if (foto != null) {
                                _fotoTemp = foto.path;
                                setStateDialog(() {});
                              }
                            },
                            icon: const Icon(Icons.camera_alt),
                            label: Text(
                              _fotoTemp == null ? 'Câmera' : 'Trocar (câmera)',
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Text('Ativo'),
                        const SizedBox(width: 8),
                        Switch(
                          value: ativo,
                          onChanged: (value) {
                            ativo = value;
                            setStateDialog(() {});
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(dialogCtx),
                  child: const Text('Cancelar'),
                ),
                TextButton(
                  onPressed: () async {
                    final nome = nomeCtrl.text.trim();
                    final precoTexto = precoCtrl.text.trim();

                    if (nome.isEmpty || precoTexto.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Nome e preço são obrigatórios'),
                        ),
                      );
                      return;
                    }

                    final preco =
                        double.tryParse(precoTexto.replaceAll(',', '.')) ?? 0.0;

                    final agora = DateTime.now().toIso8601String();

                    if (atendimento == null) {
                      final novo = Atendimento(
                        id: 0,
                        nome: nome,
                        descricao: descCtrl.text.trim().isEmpty
                            ? null
                            : descCtrl.text.trim(),
                        data: agora,
                        ativo: ativo,
                        preco: preco,
                        foto: _fotoTemp,
                      );
                      await controller.inserirAtendimento(novo);
                    } else {
                      final atualizado = Atendimento(
                        id: atendimento.id,
                        nome: nome,
                        descricao: descCtrl.text.trim().isEmpty
                            ? null
                            : descCtrl.text.trim(),
                        data: atendimento.data ?? agora,
                        ativo: ativo,
                        preco: preco,
                        foto: _fotoTemp,
                      );
                      await controller.editarAtendimento(
                        atendimento.id,
                        atualizado,
                      );
                    }

                    if (context.mounted) {
                      Navigator.pop(dialogCtx);
                    }
                  },
                  child: const Text('Salvar'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
