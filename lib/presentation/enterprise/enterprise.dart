import 'package:flutter/material.dart';
import 'package:ioasys_app/constants/constants_images.dart';
import 'package:ioasys_app/domain/model/enterprise/enterprise_model.dart';

class Enterprise extends StatelessWidget {
  const Enterprise({
    required this.enterprise,
    Key? key,
  }) : super(key: key);
  final EnterpriseModel enterprise;

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: const Color(0xffee4c77),
          title: Text(enterprise.enterpriseName),
        ),
        body: SingleChildScrollView(
            child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20, left: 20),
                child: FadeInImage(
                  height: 200,
                  width: 120,
                  image: NetworkImage(enterprise.photo),
                  placeholder: const AssetImage(ConstantsImages.imageLoading),
                  imageErrorBuilder: (context, error, stackTrace) =>
                      Image.asset(ConstantsImages.imageError,
                          height: 200, width: 120, fit: BoxFit.fitWidth),
                  fit: BoxFit.fitWidth,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20, left: 20),
                child: Text(
                  enterprise.description,
                  style: const TextStyle(fontSize: 16),
                  textAlign: TextAlign.justify,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        )),
      );
}
