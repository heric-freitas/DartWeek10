import 'package:flutter/material.dart';
import 'package:validatorless/validatorless.dart';

import '../../../../core/ui/helpers/size_extensions.dart';
import '../../../../core/ui/styles/text_styles.dart';
import '../../../../models/payment_type_model.dart';
import '../../payment_type_controller.dart';

class PaymentTypeFormModal extends StatefulWidget {
  final PaymentTypeController controller;
  final PaymentTypeModel? model;

  const PaymentTypeFormModal({Key? key, this.model, required this.controller})
      : super(key: key);

  @override
  State<PaymentTypeFormModal> createState() => _PaymentTypeFormModalState();
}

class _PaymentTypeFormModalState extends State<PaymentTypeFormModal> {
  final key = GlobalKey<FormState>();
  final nameEC = TextEditingController();
  final acronuymEC = TextEditingController();
  var enabled = false;

  void _closeModal() => Navigator.of(context).pop();

  @override
  void dispose() {
    nameEC.dispose();
    acronuymEC.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    final paymentModel = widget.model;
    if (paymentModel != null) {
      nameEC.text = paymentModel.name;
      acronuymEC.text = paymentModel.acronym;
      enabled = paymentModel.enabled;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = context.screenWidth;

    return SingleChildScrollView(
      child: Container(
        width: screenWidth * (screenWidth > 1200 ? .5 : .7),
        padding: const EdgeInsets.all(30),
        child: Form(
          key: key,
          child: Column(
            children: [
              Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      '${widget.model == null ? 'Adicionar' : 'Editar'} forma de pagamento',
                      textAlign: TextAlign.center,
                      style: context.textStyles.textTitle,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: _closeModal,
                      child: const Icon(Icons.close),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: nameEC,
                decoration: const InputDecoration(
                  label: Text('Nome'),
                ),
                validator: Validatorless.required('Nome Obrigatório'),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: acronuymEC,
                decoration: const InputDecoration(
                  label: Text('Sigla'),
                ),
                validator: Validatorless.required('Sigla Obrigatória'),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text(
                    'Ativo:',
                    style: context.textStyles.textRegular,
                  ),
                  Switch(
                    value: enabled,
                    onChanged: (value) {
                      setState(() {
                        enabled = value;
                      });
                    },
                  )
                ],
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: 60,
                    padding: const EdgeInsets.all(8),
                    child: OutlinedButton(
                      onPressed: _closeModal,
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                          color: Colors.red,
                        ),
                      ),
                      child: Text(
                        'Cancelar',
                        style: context.textStyles.textExtraBold.copyWith(
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 60,
                    padding: const EdgeInsets.all(8),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        final valid = key.currentState?.validate() ?? false;

                        if (valid) {
                          final name = nameEC.text;
                          final acronuym = acronuymEC.text;

                          widget.controller.savePayment(
                            name: name,
                            acronym: acronuym,
                            enabled: enabled,
                            id: widget.model?.id,
                          );
                        }
                      },
                      icon: const Icon(Icons.save),
                      label: const Text('Salvar'),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
