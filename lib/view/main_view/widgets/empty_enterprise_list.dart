import 'package:flutter/material.dart';
import 'package:ioasys_app/generated/l10n.dart';

class EmptyEnterpriseList extends StatelessWidget {
  const EmptyEnterpriseList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 40, 20, 40),
          child: Text(
            S.of(context).mainScreenNoEnterpriseResult,
            style: const TextStyle(fontSize: 18, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        ),
      );
}
