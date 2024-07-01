//
//  DeliveryViewModel.swift
//  tea-mail-shop
//
//  Created by Наталья Мазур on 23.06.24.
//

import Foundation

class DeliveryViewModel: ObservableObject {
    @Published
    var deliveryOptions = [DeliveryAndPaymentModel]()
    
    init() {
        deliveryOptions = [
            DeliveryAndPaymentModel(option: String(localized: "Самовывоз"), description: String(localized: "Заказы собираются в порядке очереди с учётом загруженности склада. Время сборки - от трёх часов до суток в предпраздничные и акционные дни. Заказ хранится семь дней, после чего автоматически расформировывается, если срок хранения не был продлен по просьбе покупателя. В случае невостребованности заказа, последующие собираются по предварительной оплате. Каждая стадия сопровождается смс-уведомлением: «Принят в обработку»-«Собран»-«Передан на кассу». Перед визитом обязательно дождитесь смс-уведомления о готовности Вашего заказа. Забрать его можно в нашей чайной по адресу: пр-т Независимости 44-3Н, во дворе здания «Вечерний Минск». Это 2 минуты пешком от ст. метро «Площадь Победы». Вход через арку с вывеской «Чайная Почта», слева от арки пристройка с росписью в китайском стиле. Оплатить можно наличными/картой при самовывозе, либо предварительно ЕРИП или онлайн.")),
            DeliveryAndPaymentModel(option: String(localized: "Доставка Белпочтой"), description: String(localized: "Отправляем заказ в тот же день, либо на следующий день после оформления на сайте. Стоимость почтовой доставки заказов на сумму до 85 р. по Беларуси — 7 р. Свыше - бесплатно. Обычно посылка к примеру до Гродно или Витебска идет 2–3 дня. После отправки мы высылаем на указанный при регистрации e-mail трек-номер для отслеживания посылки на сайте Белпочты. Оплата может быть как заранее, так и на почте при получении. Не забудьте паспорт. Будьте внимательны, 3% от итоговой суммы возьмёт Белпочта за перевод денег на наш расчетный счет в банке. Чтобы не платить эту комиссию, вы можете воспользоваться системой денежных переводов ЕРИП, а нам будет выгоднее отправить посылку без наложенного платежа. Во время формирования заказа в графе «Оплата» укажите способ оплаты: ЕРИП, и мы отправим вам номер счета для оплаты в виде SMS на указанный номер телефона. После получения оплаты от вас отправим заказ. Также доступна оплата онлайн по картам Visa и MasterCard.")),
            DeliveryAndPaymentModel(option: String(localized: "Курьерская доставка"), description: String(localized: "Доставка по Минску в пределах МКАД возможна как в день заказа, так и в любой удобный вам день. Стоимость курьерской доставки для заказов до 85 р. - 7 р. Заказы на сумму от 85 р. доставляются бесплатно с 12.00 до 22.00. В комментарии пожалуйста укажите желаемое время заказа. Курьером за пределы МКАД в близлежащие районы: заказы на 150 BYN и более в районы Минской области, граничащие с МКАД доставим бесплатно. До 150 BYN - за 15 BYN. Оплата наличными или картой курьеру или предоплата по ЕРИП или карте.")),
            DeliveryAndPaymentModel(option: String(localized: "Маршруткой по РБ"), description: String(localized: "Возможна доставка с помощью маршрутки, если есть прямое сообщение с Минском. Стоимость такого способа доставки 15 р. (за курьерские услуги по Минску и оплату маршрутки). Такие заказы отправляются только по предоплате удобным способом - картой онлайн или ЕРИП. Все заказы от 150 BYN доставляются таким способом бесплатно.")),
            DeliveryAndPaymentModel(option: String(localized: "Бесплатная доставка"), description: String(localized: "Любые заказы от 85 BYN с доставкой по Минску курьером или почтой по Беларуси. Доставка с помощью EMS-службы бесплатна от 150 BYN. Заказы от 6000 RUB СДЭКом до отделения СДЭКа в вашем городе. Заказы от 8000 RUB - курьерской службой СДЭК до вашей двери.")),
            DeliveryAndPaymentModel(option: String(localized: "Доставка СДЭКом"), description: String(localized: "Доставка до вашей двери или отделения СДЭКа в вашем городе - стоимость 600 RUB. Бесплатно доставляем заказы от 6000 RUB СДЭКом до отделения СДЭКа в вашем городе, а заказы от 8000 RUB - курьерской службой СДЭК до вашей двери.")),
            DeliveryAndPaymentModel(option: String(localized: "Доставка по всему миру"), description: String(localized: "Доставка в другие страны производится с помощью EMS службы, стоимость предварительно согласовывается с получателем. Для уточнения стоимости напишите нам запрос на почту dostavka.teamail@gmail.com или телеграм https://t.me/tea_mail (c 12 до 19). Вам срочно нужен чай? Мы найдем способ его вам доставить! Есть опыт доставок на Кипр, Израиль, Польшу, Канаду, США, Индонезию, Португалию и другие страны.")),
        ]
    }
}
