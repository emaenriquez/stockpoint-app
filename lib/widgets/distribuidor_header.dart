import 'package:flutter/material.dart';
import '../../data/mock_data_service.dart';

class DistribuidorHeader extends StatelessWidget implements PreferredSizeWidget {
  final String titulo;

  const DistribuidorHeader({
    Key? key,
    required this.titulo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 1,
      title: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(
              MockDataService.usuarioActual?.foto ?? 
              'https://via.placeholder.com/150',
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              titulo,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}