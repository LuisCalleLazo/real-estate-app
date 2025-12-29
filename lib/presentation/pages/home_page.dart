// lib/screens/home_page.dart
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  static String name = 'home_page';
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App Bar personalizado
          const _CustomAppBar(),

          // Contenido
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Hero Section
                const _HeroSection(),

                const SizedBox(height: 32),

                // Filtros rápidos
                const _QuickFilters(),

                const SizedBox(height: 32),

                // Propiedades destacadas
                const _FeaturedProperties(),

                const SizedBox(height: 32),

                // Por qué elegirnos
                const _WhyChooseUs(),

                const SizedBox(height: 32),

                // Estadísticas
                const _Statistics(),

                const SizedBox(height: 32),

                // CTA Final
                const _CTASection(),

                const SizedBox(height: 48),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ==================== WIDGETS REUTILIZABLES ====================

class _CustomAppBar extends StatelessWidget {
  const _CustomAppBar();

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      pinned: true,
      expandedHeight: 0,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0,
      title: Row(
        children: [
          Icon(
            Icons.home_rounded,
            color: Theme.of(context).colorScheme.primary,
            size: 32,
          ),
          const SizedBox(width: 8),
          Text(
            'Servvys',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            // Navegar a búsqueda
          },
        ),
        IconButton(
          icon: const Icon(Icons.favorite_border),
          onPressed: () {
            // Navegar a favoritos
          },
        ),
        const SizedBox(width: 8),
      ],
    );
  }
}

class _HeroSection extends StatelessWidget {
  const _HeroSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Encuentra tu\nhogar ideal',
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
              fontWeight: FontWeight.bold,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Descubre las mejores propiedades en La Paz, Bolivia',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Theme.of(context).textTheme.bodySmall?.color,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Navegar al mapa
                  },
                  icon: const Icon(Icons.map),
                  label: const Text('Ver Mapa'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    context.go("/auth/login");
                  },
                  icon: const Icon(Icons.person_add),
                  label: const Text('Login'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    context.go("/auth/register");
                  },
                  icon: const Icon(Icons.person_add),
                  label: const Text('Registrarse'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _QuickFilters extends StatelessWidget {
  const _QuickFilters();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            '¿Qué buscas?',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 120,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            scrollDirection: Axis.horizontal,
            children: [
              _FilterCard(
                icon: Icons.home,
                label: 'Casas',
                color: Colors.blue.shade400,
                onTap: () {},
              ),
              _FilterCard(
                icon: Icons.apartment,
                label: 'Departamentos',
                color: Colors.purple.shade400,
                onTap: () {},
              ),
              _FilterCard(
                icon: Icons.landscape,
                label: 'Terrenos',
                color: Colors.green.shade400,
                onTap: () {},
              ),
              _FilterCard(
                icon: Icons.business,
                label: 'Oficinas',
                color: Colors.orange.shade400,
                onTap: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _FilterCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _FilterCard({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      margin: const EdgeInsets.only(right: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: color.withValues(alpha: 0.3), width: 2),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color, size: 40),
              const SizedBox(height: 8),
              Text(
                label,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FeaturedProperties extends StatelessWidget {
  const _FeaturedProperties();

  @override
  Widget build(BuildContext context) {
    final properties = [
      _PropertyData(
        id: '1',
        title: 'Casa en Calacoto',
        price: '\$240,000',
        location: 'Calacoto, La Paz',
        bedrooms: 3,
        bathrooms: 2,
        area: '180m²',
        image:
            'https://images.unsplash.com/photo-1568605114967-8130f3a36994?w=800',
        featured: true,
      ),
      _PropertyData(
        id: '2',
        title: 'Departamento Sopocachi',
        price: '\$120,000',
        location: 'Sopocachi, La Paz',
        bedrooms: 2,
        bathrooms: 1,
        area: '85m²',
        image:
            'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=800',
        featured: true,
      ),
      _PropertyData(
        id: '3',
        title: 'Casa San Miguel',
        price: '\$180,000',
        location: 'San Miguel, La Paz',
        bedrooms: 4,
        bathrooms: 3,
        area: '220m²',
        image:
            'https://images.unsplash.com/photo-1613490493576-7fde63acd811?w=800',
        featured: false,
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Propiedades Destacadas',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              TextButton(onPressed: () {}, child: const Text('Ver todas')),
            ],
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 320,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            scrollDirection: Axis.horizontal,
            itemCount: properties.length,
            itemBuilder: (context, index) {
              return PropertyCard(property: properties[index]);
            },
          ),
        ),
      ],
    );
  }
}

class PropertyCard extends StatelessWidget {
  final _PropertyData property;

  const PropertyCard({required this.property});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      margin: const EdgeInsets.only(right: 16),
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () {
            // Navegar a detalle
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Imagen
              Stack(
                children: [
                  CachedNetworkImage(
                    imageUrl: property.image,
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      color: Colors.grey.shade200,
                      child: const Center(child: CircularProgressIndicator()),
                    ),
                  ),
                  if (property.featured)
                    Positioned(
                      top: 12,
                      left: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'Destacado',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                    ),
                  Positioned(
                    top: 12,
                    right: 12,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: IconButton(
                        icon: const Icon(Icons.favorite_border),
                        iconSize: 20,
                        onPressed: () {},
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),

              // Información
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      property.price,
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      property.title,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 14,
                          color: Theme.of(context).textTheme.bodySmall?.color,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            property.location,
                            style: Theme.of(context).textTheme.bodySmall,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        _IconLabel(
                          icon: Icons.bed,
                          label: '${property.bedrooms}',
                        ),
                        const SizedBox(width: 12),
                        _IconLabel(
                          icon: Icons.bathroom,
                          label: '${property.bathrooms}',
                        ),
                        const SizedBox(width: 12),
                        _IconLabel(
                          icon: Icons.square_foot,
                          label: property.area,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _IconLabel extends StatelessWidget {
  final IconData icon;
  final String label;

  const _IconLabel({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 16,
          color: Theme.of(context).textTheme.bodySmall?.color,
        ),
        const SizedBox(width: 4),
        Text(label, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}

class _WhyChooseUs extends StatelessWidget {
  const _WhyChooseUs();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '¿Por qué InmoBol?',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 24),
          _FeatureItem(
            icon: Icons.verified_user,
            title: 'Propiedades Verificadas',
            description: 'Todas nuestras propiedades son verificadas con IA',
            color: Colors.blue,
          ),
          const SizedBox(height: 16),
          _FeatureItem(
            icon: Icons.support_agent,
            title: 'Soporte 24/7',
            description: 'Te acompañamos en todo el proceso',
            color: Colors.green,
          ),
          const SizedBox(height: 16),
          _FeatureItem(
            icon: Icons.shield,
            title: 'Transacciones Seguras',
            description: 'Proceso legal y financiero respaldado',
            color: Colors.orange,
          ),
          const SizedBox(height: 16),
          _FeatureItem(
            icon: Icons.map,
            title: 'Mapas Interactivos',
            description: 'Explora con tours 360° y vista satelital',
            color: Colors.purple,
          ),
        ],
      ),
    );
  }
}

class _FeatureItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final Color color;

  const _FeatureItem({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color, size: 28),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
              ),
              Text(description, style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ),
      ],
    );
  }
}

class _Statistics extends StatelessWidget {
  const _Statistics();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.primary.withValues(alpha: 0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Text(
            'Confían en nosotros',
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(color: Colors.white),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _StatItem(number: '500+', label: 'Propiedades'),
              _StatItem(number: '1,200+', label: 'Clientes'),
              _StatItem(number: '98%', label: 'Satisfacción'),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String number;
  final String label;

  const _StatItem({required this.number, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          number,
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Colors.white.withValues(alpha: 0.9),
          ),
        ),
      ],
    );
  }
}

class _CTASection extends StatelessWidget {
  const _CTASection();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.2),
          width: 2,
        ),
      ),
      child: Column(
        children: [
          Icon(
            Icons.rocket_launch,
            size: 48,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: 16),
          Text(
            '¿Listo para encontrar tu hogar?',
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Únete a miles de personas que ya encontraron su lugar ideal',
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // Navegar a registro
              },
              child: const Text('Crear cuenta gratis'),
            ),
          ),
          const SizedBox(height: 12),
          TextButton(
            onPressed: () {
              // Navegar al mapa
            },
            child: const Text('O explora el mapa'),
          ),
        ],
      ),
    );
  }
}

// ==================== MODELOS ====================

class _PropertyData {
  final String id;
  final String title;
  final String price;
  final String location;
  final int bedrooms;
  final int bathrooms;
  final String area;
  final String image;
  final bool featured;

  _PropertyData({
    required this.id,
    required this.title,
    required this.price,
    required this.location,
    required this.bedrooms,
    required this.bathrooms,
    required this.area,
    required this.image,
    required this.featured,
  });
}
