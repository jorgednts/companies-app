import 'package:flutter/material.dart';
import 'package:ioasys_app/constants/constants_images.dart';
import 'package:ioasys_app/domain/enterprise/enterprise_model.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({
    required this.enterpriseModel,
    Key? key,
  }) : super(key: key);
  final EnterpriseModel enterpriseModel;

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: const Color(0xffee4c77),
          title: Text(widget.enterpriseModel.enterpriseName),
        ),
        body: SingleChildScrollView(
            child: SizedBox.expand(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20, left: 20),
                child: FadeInImage(
                  height: 100,
                  width: 180,
                  image: NetworkImage(widget.enterpriseModel.photo),
                  placeholder: const AssetImage(ConstantsImages.imageLoading),
                  imageErrorBuilder: (context, error, stackTrace) =>
                      Image.asset(ConstantsImages.imageError,
                          height: 100, width: 180, fit: BoxFit.fitWidth),
                  fit: BoxFit.fitWidth,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20, left: 20),
                child: Text(
                  widget.enterpriseModel.description,
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
