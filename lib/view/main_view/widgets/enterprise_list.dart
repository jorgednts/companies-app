import 'package:flutter/material.dart';
import 'package:ioasys_app/constants/constants_images.dart';
import 'package:ioasys_app/domain/enterprise/enterprise_model.dart';
import 'package:ioasys_app/domain/user/user_tokens.dart';
import 'package:ioasys_app/view/result_view/result_screen.dart';

class EnterpriseList extends StatelessWidget {
  const EnterpriseList({
    required this.enterpriseList,
    required this.userTokens,
    Key? key,
  }) : super(key: key);
  final List<EnterpriseModel> enterpriseList;
  final UserTokens userTokens;

  @override
  Widget build(BuildContext context) => ListView.builder(
        itemCount: enterpriseList.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(4),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ResultScreen(
                          enterpriseId: enterpriseList[index].id,
                          userTokens: userTokens,
                        )),
              );
            },
            child: Card(
              color: Colors.white,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: FadeInImage(
                      height: 100,
                      width: 80,
                      image: NetworkImage(enterpriseList[index].photo),
                      placeholder:
                          const AssetImage(ConstantsImages.imageLoading),
                      imageErrorBuilder: (context, error, stackTrace) =>
                          Image.asset(ConstantsImages.imageError,
                              height: 100, width: 80, fit: BoxFit.fitWidth),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          enterpriseList[index].enterpriseName,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 12),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Text(
                          enterpriseList[index]
                              .enterpriseType
                              .enterpriseTypeName,
                          style: const TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 10),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Text(
                          enterpriseList[index].country,
                          style: const TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
