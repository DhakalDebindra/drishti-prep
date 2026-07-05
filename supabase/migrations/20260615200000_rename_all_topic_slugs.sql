-- Rename all verbose/English topic names to approved keyword slugs
-- Fix 3 subject name spellings
-- DB's richer granularity (1.9 × 6, 1.11 × 10, 1.12 × 11) is KEPT — just clean names

-- ============================================================
-- SUBJECTS: fix spelling/formatting
-- ============================================================
UPDATE public.subjects SET name = 'Science, Technology & Health',  name_np = 'विज्ञान, प्रविधि र स्वास्थ्य'   WHERE id = '7be492ff-f9be-41e6-b632-18ebc5c2416f';
UPDATE public.subjects SET name = 'Current Affairs',               name_np = 'समसामयिक घटना'                  WHERE id = 'a2a04965-3137-4ee2-aea3-e3b8b41a7047';
UPDATE public.subjects SET name = 'Nepal Constitution & Governance',name_np = 'नेपालको संविधान र शासन व्यवस्था' WHERE id = '38c59885-e272-474f-8798-be7e5dfae798';

-- ============================================================
-- 1.1 ब्रह्माण्ड
-- ============================================================
UPDATE public.topics SET name = 'सौर्यमण्डल'              WHERE id = 'e4669424-e6ea-4432-b9de-9906631758c6';
UPDATE public.topics SET name = 'पृथ्वीको संरचना र गति'  WHERE id = '091645c1-4826-4980-87d2-6dbdcf7875b0';

-- ============================================================
-- 1.2 विश्वको भूगोल
-- ============================================================
UPDATE public.topics SET name = 'अक्षांश, देशान्तर र समय'         WHERE id = '6fbb8c52-1991-4718-b7f9-437400e6a1a1';
UPDATE public.topics SET name = 'पर्वत, मरुभूमि र प्राकृतिक परिघटना' WHERE id = '77fff8bd-42f5-4c25-84fc-d0ebd77ca503';
UPDATE public.topics SET name = 'नदी, ताल र हिमनदी'               WHERE id = 'fc362243-9e66-45dd-8567-a7d23e55b69a';
UPDATE public.topics SET name = 'जलवायु र वायुमण्डल'              WHERE id = 'e95a5c6c-b208-47f2-8967-7013013edcb6';

-- ============================================================
-- 1.4 विश्वको इतिहास
-- ============================================================
UPDATE public.topics SET name = 'प्रमुख विश्व घटनाक्रम'    WHERE id = '28f50314-50d3-45f7-8c81-9741b812f589';
UPDATE public.topics SET name = 'विश्व क्रान्ति र आन्दोलन' WHERE id = '3d0af756-8941-473e-ae9a-c738df292e35';
UPDATE public.topics SET name = 'प्रथम र द्वितीय विश्वयुद्ध' WHERE id = '6c7916c4-5fa4-4147-b75e-072c9e10a186';

-- ============================================================
-- 1.6 सामाजिक एवं सांस्कृतिक
-- ============================================================
UPDATE public.topics SET name = 'जनसंख्या, जातजाति र धर्म'    WHERE id = '0c2194a0-a5c1-47cc-a8bb-b63285fb27f7';
UPDATE public.topics SET name = 'संस्कृति र सांस्कृतिक सम्पदा' WHERE id = '5f7a0922-4dd7-453e-a0b6-a7068404eaa3';

-- ============================================================
-- 1.8 विज्ञान, प्रविधि र स्वास्थ्य
-- ============================================================
UPDATE public.topics SET name = 'आविष्कार र प्रविधि'         WHERE id = '35b7a731-cc67-486a-9ed3-2c18ec94b27a';
UPDATE public.topics SET name = 'जैविक प्रविधि र वैकल्पिक ऊर्जा' WHERE id = '6b9d5218-4120-46ae-b2da-bad7b1948f6d';
UPDATE public.topics SET name = 'मानव शरीर र स्वास्थ्य'       WHERE id = '22efaeb6-2703-435d-abbf-fbf345837be7';
UPDATE public.topics SET name = 'दैनिक जीवनको विज्ञान'        WHERE id = '2b1a846e-9027-4392-8d35-f9100dff835e';

-- ============================================================
-- 1.9 पारिस्थितिक पद्धति र वातावरण
-- ============================================================
UPDATE public.topics SET name = 'दिगो विकास'                       WHERE id = 'c4e89c03-8589-4c88-bada-d5f9298eca00';
UPDATE public.topics SET name = 'पारिस्थितिक पद्धति र जैविक विविधता' WHERE id = 'f423de8a-c0f7-4567-81f2-96dd0bd327af';
UPDATE public.topics SET name = 'संरक्षित क्षेत्र'                 WHERE id = '13da78f9-bafa-4677-9b47-5d531bf2d8dd';
UPDATE public.topics SET name = 'वातावरणीय समस्या'                 WHERE id = 'edcada75-e4d9-45bd-9d74-11a4f2f16b15';
UPDATE public.topics SET name = 'अन्तर्राष्ट्रिय सन्धि र सम्मेलन'  WHERE id = '11c21d9c-6f76-4847-861b-47e365a75f8f';

-- ============================================================
-- 1.10 अन्तर्राष्ट्रिय सम्बन्ध
-- ============================================================
UPDATE public.topics SET name = 'परराष्ट्र नीति र द्विपक्षीय सम्बन्ध' WHERE id = '0caa0a35-51c5-40bb-b46f-e97893f9e139';
UPDATE public.topics SET name = 'संयुक्त राष्ट्रसंघ'                  WHERE id = '285cb410-f80d-4f9f-a32a-b07ba0ad43fd';
UPDATE public.topics SET name = 'क्षेत्रीय संगठन'                    WHERE id = 'd71d3b8b-111e-4260-8de3-f6e471d0561a';

-- ============================================================
-- 1.12 नेपालको संविधान र शासन व्यवस्था
-- ============================================================
UPDATE public.topics SET name = 'संवैधानिक इतिहास'                   WHERE id = '7130b022-4632-4dcf-b8ba-b29725548aec';
UPDATE public.topics SET name = 'संविधानको परिचय र प्रारम्भिक व्यवस्था' WHERE id = '26205e7b-e5de-4d0f-a8cc-cd31d549a623';
UPDATE public.topics SET name = 'नागरिकता सम्बन्धी व्यवस्था'          WHERE id = 'b81803ff-1bfc-476b-b66c-3b0d87b47169';
UPDATE public.topics SET name = 'मौलिक हक र कर्तव्य'                 WHERE id = 'cb490683-a1e3-4227-b2b9-bb72da6bdb33';
UPDATE public.topics SET name = 'निर्देशक सिद्धान्त र राज्य नीति'     WHERE id = 'bda7135a-9bc1-4f59-89aa-62952bba342e';
UPDATE public.topics SET name = 'राज्य संरचना र शक्ति बाँडफाँड'       WHERE id = '291aea03-f1a0-44e5-983e-1fa5f2358974';
UPDATE public.topics SET name = 'कार्यपालिका'                        WHERE id = 'd011e58e-2b13-487f-874d-3e922d345bed';
UPDATE public.topics SET name = 'व्यवस्थापिका'                       WHERE id = 'db7b97b9-0702-40cb-a738-d4e9e525509c';
UPDATE public.topics SET name = 'संवैधानिक निकाय'                    WHERE id = '79659c10-a751-4c00-8cb3-db168964e97f';
UPDATE public.topics SET name = 'संवैधानिक विविध तथ्य'               WHERE id = 'f7e9e471-5e2c-49fc-8a8d-d2c321bb3228';
