import { ScrollView, Text, View, StyleSheet } from 'react-native';

const NEPALI_SAMPLE = `
नेपाल एक सुन्दर देश हो।
परीक्षा तयारी गर्नुहोस्।
विज्ञान • गणित • इतिहास • भूगोल
संयुक्त व्यञ्जन: क्ष त्र ज्ञ श्र
`;

export default function SmokeTest() {
  return (
    <ScrollView style={{ flex: 1, padding: 24, backgroundColor: '#fff' }}>
      <Text style={styles.label}>Regular (400)</Text>
      <Text style={styles.nepali400}>{NEPALI_SAMPLE}</Text>

      <Text style={[styles.label, { marginTop: 24 }]}>Bold (700)</Text>
      <Text style={styles.nepali700}>{NEPALI_SAMPLE}</Text>

      <Text style={[styles.label, { marginTop: 24, color: '#fff', backgroundColor: '#111' }]}>
        Dark mode simulation
      </Text>
      <View style={{ backgroundColor: '#111', padding: 16, borderRadius: 8 }}>
        <Text style={[styles.nepali400, { color: '#f5f5f5' }]}>{NEPALI_SAMPLE}</Text>
      </View>
    </ScrollView>
  );
}

const styles = StyleSheet.create({
  label: { fontSize: 12, fontWeight: 'bold', color: '#888', marginBottom: 8 },
  nepali400: { fontSize: 18, fontFamily: 'NotoSansDevanagari_400Regular', lineHeight: 32, color: '#111' },
  nepali700: { fontSize: 18, fontFamily: 'NotoSansDevanagari_700Bold', lineHeight: 32, color: '#111' },
});
