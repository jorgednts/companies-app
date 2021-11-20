import 'package:flutter/material.dart';
import 'package:ioasys_app/constants/constants_images.dart';
import 'package:ioasys_app/domain/model/enterprise/enterprise_model.dart';
import 'package:ioasys_app/domain/model/user/user_tokens.dart';

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
              Navigator.of(context).pushNamed(
                  'result-screen/${enterpriseList[index].id}',
                  arguments: userTokens);
            },
            child: Card(
              color: Colors.white,
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: FadeInImage(
                        image: NetworkImage(enterpriseList[index].photo),
                        placeholder:
                            const AssetImage(ConstantsImages.imageLoading),
                        imageErrorBuilder: (context, error, stackTrace) =>
                            Image.asset(
                          ConstantsImages.imageError,
                          fit: BoxFit.fitWidth,
                        ),
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          enterpriseList[index].enterpriseName,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          enterpriseList[index]
                              .enterpriseType
                              .enterpriseTypeName,
                          style: const TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Text(
                          enterpriseList[index].country,
                          style: const TextStyle(
                            fontStyle: FontStyle.normal,
                            fontSize: 12,
                            color: Colors.grey,
                          ),
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
