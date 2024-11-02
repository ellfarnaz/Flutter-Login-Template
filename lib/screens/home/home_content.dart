import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widget/grid_view_section.dart';
import '../widget/list_view_section.dart';

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  _HomeContentState createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  late ScrollController _scrollController;
  bool _isScrolled = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.offset > 0 && !_isScrolled) {
      setState(() {
        _isScrolled = true;
      });
    } else if (_scrollController.offset <= 0 && _isScrolled) {
      setState(() {
        _isScrolled = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: BoxDecoration(
            color: _isScrolled ? Color(0xFFB3CEFA) : Colors.grey[100],
            boxShadow: _isScrolled
                ? [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.4),
                      spreadRadius: 3,
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ]
                : [],
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leadingWidth: 0,
            titleSpacing: 0,
            title: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildIconButton(
                    context,
                    Icons.account_circle_sharp,
                    size: 27,
                    () {
                      // Handle profile icon press
                    },
                  ),
                  Row(
                    children: [
                      _buildIconButton(
                        context,
                        Icons.notifications_outlined,
                        size: 24,
                        () {
                          // Handle notifications icon press
                        },
                      ),
                      const SizedBox(width: 16),
                      _buildIconButton(
                        context,
                        Icons.settings_outlined,
                        size: 24,
                        () {
                          // Handle settings icon press
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Container(
          color: Colors.grey[100],
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 20),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Farel Naufal A',
                        style: GoogleFonts.poppins(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const GridViewSection(),
              const SizedBox(height: 25),
              const ListViewSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIconButton(
      BuildContext context, IconData icon, VoidCallback onPressed,
      {required double size}) {
    return SizedBox(
      width: 40,
      height: 40,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onPressed,
          child: Icon(
            icon,
            size: size,
            color: Theme.of(context).textTheme.bodyLarge?.color,
          ),
        ),
      ),
    );
  }
}
