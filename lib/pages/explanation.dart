import 'package:flutter/material.dart';

class ExplanationPage extends StatelessWidget {
  const ExplanationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '컴퓨터 부품 설명',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              '컴퓨터 부품 및 조립 가이드',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            _buildExpansionTile(
              title: 'CPU (중앙 처리 장치)',
              description:
                  'CPU는 컴퓨터의 두뇌 역할을 하며, 명령을 실행하고 데이터를 처리합니다. 시스템 내에서 모든 계산과 논리 작업을 수행합니다.',
            ),
            _buildExpansionTile(
              title: '메인보드 (Motherboard)',
              description:
                  '메인보드는 컴퓨터의 중심 역할을 하며, CPU, GPU, RAM, 저장 장치 등 모든 부품을 연결합니다. 이 부품들이 서로 통신하고 협력할 수 있도록 도와줍니다.',
            ),
            _buildExpansionTile(
              title: '그래픽 카드 (GPU)',
              description:
                  '그래픽 카드는 이미지, 비디오, 애니메이션을 렌더링하는 장치입니다. 게임, 비디오 편집, 그래픽이 많이 필요한 작업에 필수적입니다.',
            ),
            SizedBox(height: 24),
            Text(
              '조립 가이드',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            _buildAssemblyStep(
              step: '1단계',
              title: 'CPU 설치',
              description:
                  '메인보드의 CPU 소켓을 열고, CPU를 소켓에 맞춰 신중하게 놓습니다. 소켓 레버로 CPU를 고정합니다.',
            ),
            _buildAssemblyStep(
              step: '2단계',
              title: 'RAM 장착',
              description:
                  '메인보드의 RAM 슬롯을 찾아 RAM을 슬롯의 노치에 맞춰 삽입하고 클릭 소리가 날 때까지 눌러 고정합니다.',
            ),
            _buildAssemblyStep(
              step: '3단계',
              title: '그래픽 카드 부착',
              description: '메인보드의 PCIe 슬롯에 그래픽 카드를 삽입합니다. 움직이지 않도록 나사로 고정합니다.',
            ),
            _buildAssemblyStep(
              step: '4단계',
              title: '전원 공급 장치 연결',
              description:
                  '파워 서플라이에서 나온 전원 케이블을 메인보드, CPU, 그래픽 카드에 연결합니다. 모든 연결이 단단히 고정되었는지 확인합니다.',
            ),
            _buildAssemblyStep(
              step: '5단계',
              title: '마무리 및 테스트',
              description:
                  '모든 부품이 연결되고 고정되었는지 확인합니다. 케이스를 닫고 전원을 켜서 시스템이 제대로 작동하는지 테스트합니다.',
            ),
          ],
        ),
      ),
    );
  }

  // 부품 설명을 위한 ExpansionTile 빌드 메서드
  Widget _buildExpansionTile(
      {required String title, required String description}) {
    return ExpansionTile(
      title: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            description,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }

  // 조립 가이드 단계를 위한 메서드
  Widget _buildAssemblyStep({
    required String step,
    required String title,
    required String description,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$step: $title',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4),
          Text(
            description,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
