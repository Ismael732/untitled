import 'package:flutter/material.dart';
import 'widgets/tool_card.dart';
import '../controllers/home_controller.dart';
import '../views/settings_page.dart';
import '../views/notifications_page.dart';
import '../views/service_status_page.dart';
import '../views/schedule_page.dart';
import '../views/contacts_page.dart';
import '../views/receipts_reviews_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final HomeController _controller = HomeController();

  // Função para tratar as ações de navegação da BottomNavigationBar
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 2) {
      _controller.navigateToNotificationsPage(context); // Navega para Notificações
    } else {
      _controller.handleBottomNavigationTap(index, context);
    }
  }

  // Função para navegar para as páginas do Drawer
  void _navigateToPage(String page) {
    switch (page) {
      case 'settings':
        _controller.navigateToSettingsPage(context);
        break;
      case 'notifications':
        _controller.navigateToNotificationsPage(context);
        break;
      case 'serviceStatus':
        _controller.navigateToServiceStatusPage(context);
        break;
      case 'schedule':
        _controller.navigateToSchedulePage(context);
        break;
      case 'contacts':
        _controller.navigateToContactsPage(context);
        break;
      case 'receipts':
        _controller.navigateToReceiptsReviewsPage(context);
        break;
      default:
        break;
    }
    Navigator.of(context).pop(); // Fecha o Drawer após a navegação
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
            Scaffold.of(context).openDrawer(); // Abre o Drawer
          },
        ),
        actions: [

        ],
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.blue[100],
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue[700],
                ),
                child: Text(
                  'Menu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Configurações'),
                onTap: () => _navigateToPage('settings'),
              ),
              ListTile(
                leading: Icon(Icons.notifications),
                title: Text('Notificações'),
                onTap: () => _navigateToPage('notifications'),
              ),
              ListTile(
                leading: Icon(Icons.assignment),
                title: Text('Status de Serviço'),
                onTap: () => _navigateToPage('serviceStatus'),
              ),
              ListTile(
                leading: Icon(Icons.calendar_today),
                title: Text('Agendamentos'),
                onTap: () => _navigateToPage('schedule'),
              ),
              ListTile(
                leading: Icon(Icons.contacts),
                title: Text('Contatos'),
                onTap: () => _navigateToPage('contacts'),
              ),
              ListTile(
                leading: Icon(Icons.receipt),
                title: Text('Recibos e Avaliações'),
                onTap: () => _navigateToPage('receipts'),
              ),
            ],
          ),
        ),
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
