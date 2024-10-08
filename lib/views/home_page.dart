import 'package:flutter/material.dart';
import 'widgets/tool_card.dart';
import '../controllers/home_controller.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final HomeController _controller = HomeController();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    _controller.handleBottomNavigationTap(index, context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Início', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue[700],
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.white),
          onPressed: () {
            _controller.showMessage(context, 'Menu');
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings, color: Colors.white),
            onPressed: () {
              _controller.showMessage(context, 'Configurações');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(30.0)),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.33,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.blue[800]!,
                    Colors.blue[400]!,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                image: DecorationImage(
                  image: AssetImage('assets/images/imagemB.png'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      Colors.blue.withOpacity(0.5), BlendMode.dstATop),
                ),
              ),
              child: Center(
                child: Image.asset(
                  'assets/images/imagemA.png',
                  width: 180,
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                color: Colors.white,
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  children: [
                    ToolCard(
                        title: 'Status de Serviço',
                        icon: Icons.assignment,
                        onTap: () {
                          _controller.navigateToServiceStatusPage(context);
                        }),
                    ToolCard(
                        title: 'Agendamentos',
                        icon: Icons.calendar_today,
                        onTap: () {
                          _controller.navigateToSchedulePage(context);
                        }),
                    ToolCard(
                        title: 'Contatos',
                        icon: Icons.contacts,
                        onTap: () {
                          _controller.navigateToContactsPage(context);
                        }),
                    ToolCard(
                        title: 'Recibos e Avaliações',
                        icon: Icons.receipt,
                        onTap: () {
                          _controller.navigateToReceiptsReviewsPage(context);
                        }),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blue[800],
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.white),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search, color: Colors.white),
            label: 'Pesquisar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications, color: Colors.white),
            label: 'Notificações',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }
}
