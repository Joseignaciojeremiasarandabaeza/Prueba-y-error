Prueba y Error: Infraestructura y CI/CD Estándar

Este repositorio no solo representa una prueba de infraestructura, sino que sirve como una capa de abstracción estandarizada para el despliegue de recursos en AWS utilizando Terraform y la automatización de políticas de seguridad a través de OPA (Open Policy Agent).

🏗️ Arquitectura de la Solución

El proyecto plantea una topología de red robusta y segura:

- **Networking**: Configuración de una VPC personalizada con segmentación entre subredes públicas y privadas.
- **Gateway**: Implementación de un NAT Gateway para permitir salidas seguras a internet desde subredes privadas.
- **Cómputo**: Automatización de instancias EC2 mediante scripts personalizados (`install.sh`).
- **Compliance**: Uso de reglas definidas en archivos `.rego` para validar la infraestructura antes del despliegue.

🛠️ Integración de Componentes Externos (Criterio 2)

Para maximizar la agilidad y seguridad, se ha distinguido entre componentes externos (Marketplace) y desarrollos propios:

| Componente            | Origen       | Justificación Técnica                                                                                     |
|-----------------------|--------------|----------------------------------------------------------------------------------------------------------|
| HashiCorp Terraform   | Externo      | Herramienta estándar en la industria para IaC, asegurando compatibilidad y soporte con recursos de AWS. |
| Open Policy Agent (OPA)| Externo      | Motor para políticas desacopladas que habilita auditorías de seguridad sin modificar el código base.     |
| install.sh            | Interno      | Script desarrollado internamente para configurar las instancias EC2 según los requerimientos.           |
| Reglas `.rego`        | Interno      | Lógica específica para garantizar el cumplimiento normativo de los recursos creados.                    |

⚙️ Parametrización y Reutilización (Criterio 3)

El proyecto está diseñado para ser modular, promoviendo la reutilización en diferentes entornos (Dev, QA, Prod):

- **Entradas dinámicas**: Los scripts y plantillas de CI/CD aceptan variables de entorno, lo que permite cambiar el contexto del despliegue sin modificar el código fuente.
- **Abstracción**: La infraestructura está separada del flujo de ejecución, facilitando su adopción por otros equipos sin perdida de consistencia.

📈 Impacto en el Negocio (Criterio 4)

Esta implementación aporta valor estratégico en los siguientes aspectos clave:

- **Agilidad Operativa**: Transforma los procesos de aprovisionamiento, pasando de días a minutos gracias a la automatización.
- **Reducción de Errores y Costos**: Minimiza configuraciones manuales ("ClickOps"), reduciendo brechas de seguridad y gastos por gestión ineficiente de recursos.
- **Mejora Continua y Compliance**: Las pruebas automáticas a través de reglas `.rego` garantizan que el 100 % de los recursos cumplan con las políticas de seguridad antes de ser desplegados, mitigando riesgos en producción.

📂 Estructura del Repositorio

- `provider.tf`: Configuración del proveedor AWS.
- `vpc.tf`: Definición de la topología de redes (subnets, NAT, routing).
- `ec2.tf`: Configuración de instancias EC2 y Grupos de Seguridad.
- `install.sh`: Script post-instalación para instancias EC2.
- `rules.rego`: Reglas para validación y cumplimiento normativo.

¿Cómo usar este repositorio?

1. Clona el repositorio.
2. Configura tus credenciales de AWS.
3. Ejecuta `terraform init` seguido de `terraform apply`.
4. (Opcional) Realiza pruebas con OPA sobre el plan de Terraform para validar cumplimiento normativo.