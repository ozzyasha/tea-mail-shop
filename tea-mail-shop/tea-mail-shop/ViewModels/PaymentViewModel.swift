//
//  PaymentViewModel.swift
//  tea-mail-shop
//
//  Created by Наталья Мазур on 23.06.24.
//

import Foundation

class PaymentViewModel: ObservableObject {
    @Published
    var paymentOptions = [DeliveryAndPaymentModel]()
    
    init() {
        paymentOptions = [
            DeliveryAndPaymentModel(option: String(localized: "Наличными или картой в чайной"), description: String(localized: "Оплата наличными или картой в магазине Чайная Почта на проспекте Независимости 44 - 3н.")),
            DeliveryAndPaymentModel(option: String(localized: "Сервис Оплати"), description: String(localized: "“Оплати” — это мобильная система оплаты электронными деньгами. Платежи проводятся с помощью QR-кода. Для оплаты достаточно только смартфон! Скачать приложение «Оплати» можно в App Store, Google Play, AppGallery:  https://getapp.o-plati.by Пополнение “виртуального кошелька” с карточек любых банков без комиссии, через ЕРИП, банковским переводом или переводом с другого кошелька «Оплати», подробнее на сайте сервиса https://www.o-plati.by Для оплаты приложением «Оплати» необходимо выбрать способ оплаты «Оплати» или указать в комментариях желаемый способ оплаты и оформить заказ. На указанный в заказе e-mail или другой удобный мессенджер придет ссылка для оплаты заказа. Перейдя по ссылке с мобильного устройства откроется приложение «Оплати» с детализацией платежа. Для оплаты необходимо нажать «Далее» и подтвердить платеж. Если ссылка открывается с ПК, то на экране появится QR-код. Отсканировать QR-код приложением «Оплати» или камерой смартфона, подтвердить оплату. Электронный чек оплаты смотреть в выписке платежей приложения «Оплати».")),
            DeliveryAndPaymentModel(option: String(localized: "Наличными курьеру"), description: String(localized: "Оплата наличными при получении заказа у курьера. В комментарии к заказу пожалуйста напишите с какой суммы приготовить сдачу и выберите желаемое время доставки.")),
            DeliveryAndPaymentModel(option: String(localized: "Картой курьеру"), description: String(localized: "Оплата картой при получении заказа у курьера. В комментарии к заказу пожалуйста напишите желаемое время доставки.")),
            DeliveryAndPaymentModel(option: String(localized: "Оплата онлайн картами через bePaid"), description: String(localized: "После нажатия кнопки «Купить» вы перейдете на специальную защищенную платежную страницу процессинговой системы bePaid (https://bepaid.by/). На платежной странице будет указан номер заказа и сумма платежа. Для оплаты вам необходимо ввести свои карточные данные и подтвердить платеж, нажав кнопку «Оплатить». Если ваша карта поддерживает технологию 3-D Secure, системой ваш будет предложено пройти стандартную одноминутную процедуру проверки владельца карты на странице вашего банка (банка, который выдал вашу карту). После оплаты наш менеджер свяжется с вами для уточнения деталей по доставке. Обращаем ваше внимание, что после проведения платежа на указанный вами электронный адрес придет подтверждение оплаты. Просим вас сохранять данные оплат. Мы принимаем платежи по следующим банковским картам: Visa, Visa Electron, MasterCard, Maestro, Белкарт. Платежи по банковским картам осуществляются через систему электронных платежей bePaid. Платежная страница системы bePaid отвечает всем требованиям безопасности передачи данных (PCI DSS Level 1). Все конфиденциальные данные хранятся в зашифрованном виде и максимально устойчивы к взлому. Доступ к авторизационным страницам осуществляется с использованием протокола, обеспечивающего безопасную передачу данных в Интернетe (SSL/TLS). Возврат денежных средств осуществляется на карту, с которой ранее была произведена оплата. Срок поступления денежных средств на карту от 1 до 30 дней с момента осуществления возврата Продавцом. Причины отказа в авторизации могут быть следующими: на карте недостаточно средств для оплаты заказа; банк, выпустивший карточку покупателя, установил запрет на оплату в интернете; истекло время ожидания ввода данных банковской карты; введённые данные не были подтверждены вами на платежной странице, ошибка формата данных и т.д. В зависимости от причины отказа в авторизации для решения вопроса вы можете: обратиться за разъяснениями в банк, выпустивший карточку покупателя; в случае невозможности решения проблемы банком — повторить попытку оплаты, воспользовавшись картой, выпущенной другим банком.")),
            DeliveryAndPaymentModel(option: String(localized: "Оплата через ЕРИП"), description: String(localized: "В вашем интернет-банкинге проходите по ветке: ЕРИП - Интернет-магазины - Латинский домен - Буква Т - tea-mail.by. В появившемся окне необходимо ввести вручную счёт (он совпадает с номером заказа) и сумму из пришедшего после сбора вашего заказа SMS. Если вы осуществляете платеж в кассе банка, пожалуйста, сообщите кассиру о необходимости проведения платежа через систему ”Расчет“ (ЕРИП). Оплатить товары вы можете через систему «Расчет» (ЕРИП), в любом удобном для вас месте, в удобное для вас время, в удобном для вас пункте банковского обслуживания – интернет-банке, с помощью мобильного банкинга, инфокиоске, кассе банков, банкомате и т. д. Совершить оплату можно с использованием наличных денежных средств, электронных денег и банковских платежных карточек в пунктах банковского обслуживания банков, которые оказывают услуги по приему платежей, а также посредством инструментов дистанционного банковского обслуживания. Для оплаты заказа введите номер счета из присланного нами SMS, введите сумму платежа, совершите платеж.")),
            DeliveryAndPaymentModel(option: String(localized: "В отделении Белпочты"), description: String(localized: "Заказ можно оплатить на почте при получении. БелПочта возьмет 3% за перевод денег на наш расчетный счет. Оплатить можно наличными или картой. Не забудьте паспорт!")),
            DeliveryAndPaymentModel(option: String(localized: "Оплата по счету на р/с (для юр. лиц)"), description: String(localized: "После согласования стоимости и наличия мы выставляем вам счет на указанные в комментарии к заказу реквизиты. Составим договор, выпишем накладную и выдадим все необходимые декларации соответствия. Для получения условия работы, а так же составление договора напишите нам dostavka.teamail@gmail.com. Рабочее время оптового отдела с 10 до 18 по будням.")),
        ]
    }
}
