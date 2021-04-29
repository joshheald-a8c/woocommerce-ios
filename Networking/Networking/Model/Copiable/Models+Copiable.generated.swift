// Generated using Sourcery 1.0.3 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT


extension Coupon {
    public func copy(
        siteID: CopiableProp<Int64> = .copy,
        couponID: CopiableProp<Int64> = .copy,
        code: CopiableProp<String> = .copy,
        amount: CopiableProp<String> = .copy,
        dateCreated: CopiableProp<Date> = .copy,
        dateModified: CopiableProp<Date> = .copy,
        discountType: CopiableProp<Coupon.DiscountType> = .copy,
        description: CopiableProp<String> = .copy,
        dateExpires: NullableCopiableProp<Date> = .copy,
        usageCount: CopiableProp<Int64> = .copy,
        individualUse: CopiableProp<Bool> = .copy,
        productIds: CopiableProp<[Int64]> = .copy,
        excludedProductIds: CopiableProp<[Int64]> = .copy,
        usageLimit: NullableCopiableProp<Int64> = .copy,
        usageLimitPerUser: NullableCopiableProp<Int64> = .copy,
        limitUsageToXItems: NullableCopiableProp<Int64> = .copy,
        freeShipping: CopiableProp<Bool> = .copy,
        productCategories: CopiableProp<[Int64]> = .copy,
        excludedProductCategories: CopiableProp<[Int64]> = .copy,
        excludeSaleItems: CopiableProp<Bool> = .copy,
        minimumAmount: CopiableProp<String> = .copy,
        maximumAmount: CopiableProp<String> = .copy,
        emailRestrictions: CopiableProp<[String]> = .copy,
        usedBy: CopiableProp<[String]> = .copy
    ) -> Coupon {
        let siteID = siteID ?? self.siteID
        let couponID = couponID ?? self.couponID
        let code = code ?? self.code
        let amount = amount ?? self.amount
        let dateCreated = dateCreated ?? self.dateCreated
        let dateModified = dateModified ?? self.dateModified
        let discountType = discountType ?? self.discountType
        let description = description ?? self.description
        let dateExpires = dateExpires ?? self.dateExpires
        let usageCount = usageCount ?? self.usageCount
        let individualUse = individualUse ?? self.individualUse
        let productIds = productIds ?? self.productIds
        let excludedProductIds = excludedProductIds ?? self.excludedProductIds
        let usageLimit = usageLimit ?? self.usageLimit
        let usageLimitPerUser = usageLimitPerUser ?? self.usageLimitPerUser
        let limitUsageToXItems = limitUsageToXItems ?? self.limitUsageToXItems
        let freeShipping = freeShipping ?? self.freeShipping
        let productCategories = productCategories ?? self.productCategories
        let excludedProductCategories = excludedProductCategories ?? self.excludedProductCategories
        let excludeSaleItems = excludeSaleItems ?? self.excludeSaleItems
        let minimumAmount = minimumAmount ?? self.minimumAmount
        let maximumAmount = maximumAmount ?? self.maximumAmount
        let emailRestrictions = emailRestrictions ?? self.emailRestrictions
        let usedBy = usedBy ?? self.usedBy

        return Coupon(
            siteID: siteID,
            couponID: couponID,
            code: code,
            amount: amount,
            dateCreated: dateCreated,
            dateModified: dateModified,
            discountType: discountType,
            description: description,
            dateExpires: dateExpires,
            usageCount: usageCount,
            individualUse: individualUse,
            productIds: productIds,
            excludedProductIds: excludedProductIds,
            usageLimit: usageLimit,
            usageLimitPerUser: usageLimitPerUser,
            limitUsageToXItems: limitUsageToXItems,
            freeShipping: freeShipping,
            productCategories: productCategories,
            excludedProductCategories: excludedProductCategories,
            excludeSaleItems: excludeSaleItems,
            minimumAmount: minimumAmount,
            maximumAmount: maximumAmount,
            emailRestrictions: emailRestrictions,
            usedBy: usedBy
        )
    }
}

extension Order {
    public func copy(
        siteID: CopiableProp<Int64> = .copy,
        orderID: CopiableProp<Int64> = .copy,
        parentID: CopiableProp<Int64> = .copy,
        customerID: CopiableProp<Int64> = .copy,
        number: CopiableProp<String> = .copy,
        status: CopiableProp<OrderStatusEnum> = .copy,
        currency: CopiableProp<String> = .copy,
        customerNote: NullableCopiableProp<String> = .copy,
        dateCreated: CopiableProp<Date> = .copy,
        dateModified: CopiableProp<Date> = .copy,
        datePaid: NullableCopiableProp<Date> = .copy,
        discountTotal: CopiableProp<String> = .copy,
        discountTax: CopiableProp<String> = .copy,
        shippingTotal: CopiableProp<String> = .copy,
        shippingTax: CopiableProp<String> = .copy,
        total: CopiableProp<String> = .copy,
        totalTax: CopiableProp<String> = .copy,
        paymentMethodID: CopiableProp<String> = .copy,
        paymentMethodTitle: CopiableProp<String> = .copy,
        items: CopiableProp<[OrderItem]> = .copy,
        billingAddress: NullableCopiableProp<Address> = .copy,
        shippingAddress: NullableCopiableProp<Address> = .copy,
        shippingLines: CopiableProp<[ShippingLine]> = .copy,
        coupons: CopiableProp<[OrderCouponLine]> = .copy,
        refunds: CopiableProp<[OrderRefundCondensed]> = .copy,
        fees: CopiableProp<[OrderFeeLine]> = .copy
    ) -> Order {
        let siteID = siteID ?? self.siteID
        let orderID = orderID ?? self.orderID
        let parentID = parentID ?? self.parentID
        let customerID = customerID ?? self.customerID
        let number = number ?? self.number
        let status = status ?? self.status
        let currency = currency ?? self.currency
        let customerNote = customerNote ?? self.customerNote
        let dateCreated = dateCreated ?? self.dateCreated
        let dateModified = dateModified ?? self.dateModified
        let datePaid = datePaid ?? self.datePaid
        let discountTotal = discountTotal ?? self.discountTotal
        let discountTax = discountTax ?? self.discountTax
        let shippingTotal = shippingTotal ?? self.shippingTotal
        let shippingTax = shippingTax ?? self.shippingTax
        let total = total ?? self.total
        let totalTax = totalTax ?? self.totalTax
        let paymentMethodID = paymentMethodID ?? self.paymentMethodID
        let paymentMethodTitle = paymentMethodTitle ?? self.paymentMethodTitle
        let items = items ?? self.items
        let billingAddress = billingAddress ?? self.billingAddress
        let shippingAddress = shippingAddress ?? self.shippingAddress
        let shippingLines = shippingLines ?? self.shippingLines
        let coupons = coupons ?? self.coupons
        let refunds = refunds ?? self.refunds
        let fees = fees ?? self.fees

        return Order(
            siteID: siteID,
            orderID: orderID,
            parentID: parentID,
            customerID: customerID,
            number: number,
            status: status,
            currency: currency,
            customerNote: customerNote,
            dateCreated: dateCreated,
            dateModified: dateModified,
            datePaid: datePaid,
            discountTotal: discountTotal,
            discountTax: discountTax,
            shippingTotal: shippingTotal,
            shippingTax: shippingTax,
            total: total,
            totalTax: totalTax,
            paymentMethodID: paymentMethodID,
            paymentMethodTitle: paymentMethodTitle,
            items: items,
            billingAddress: billingAddress,
            shippingAddress: shippingAddress,
            shippingLines: shippingLines,
            coupons: coupons,
            refunds: refunds,
            fees: fees
        )
    }
}

extension Product {
    public func copy(
        siteID: CopiableProp<Int64> = .copy,
        productID: CopiableProp<Int64> = .copy,
        name: CopiableProp<String> = .copy,
        slug: CopiableProp<String> = .copy,
        permalink: CopiableProp<String> = .copy,
        date: CopiableProp<Date> = .copy,
        dateCreated: CopiableProp<Date> = .copy,
        dateModified: NullableCopiableProp<Date> = .copy,
        dateOnSaleStart: NullableCopiableProp<Date> = .copy,
        dateOnSaleEnd: NullableCopiableProp<Date> = .copy,
        productTypeKey: CopiableProp<String> = .copy,
        statusKey: CopiableProp<String> = .copy,
        featured: CopiableProp<Bool> = .copy,
        catalogVisibilityKey: CopiableProp<String> = .copy,
        fullDescription: NullableCopiableProp<String> = .copy,
        shortDescription: NullableCopiableProp<String> = .copy,
        sku: NullableCopiableProp<String> = .copy,
        price: CopiableProp<String> = .copy,
        regularPrice: NullableCopiableProp<String> = .copy,
        salePrice: NullableCopiableProp<String> = .copy,
        onSale: CopiableProp<Bool> = .copy,
        purchasable: CopiableProp<Bool> = .copy,
        totalSales: CopiableProp<Int> = .copy,
        virtual: CopiableProp<Bool> = .copy,
        downloadable: CopiableProp<Bool> = .copy,
        downloads: CopiableProp<[ProductDownload]> = .copy,
        downloadLimit: CopiableProp<Int64> = .copy,
        downloadExpiry: CopiableProp<Int64> = .copy,
        buttonText: CopiableProp<String> = .copy,
        externalURL: NullableCopiableProp<String> = .copy,
        taxStatusKey: CopiableProp<String> = .copy,
        taxClass: NullableCopiableProp<String> = .copy,
        manageStock: CopiableProp<Bool> = .copy,
        stockQuantity: NullableCopiableProp<Decimal> = .copy,
        stockStatusKey: CopiableProp<String> = .copy,
        backordersKey: CopiableProp<String> = .copy,
        backordersAllowed: CopiableProp<Bool> = .copy,
        backordered: CopiableProp<Bool> = .copy,
        soldIndividually: CopiableProp<Bool> = .copy,
        weight: NullableCopiableProp<String> = .copy,
        dimensions: CopiableProp<ProductDimensions> = .copy,
        shippingRequired: CopiableProp<Bool> = .copy,
        shippingTaxable: CopiableProp<Bool> = .copy,
        shippingClass: NullableCopiableProp<String> = .copy,
        shippingClassID: CopiableProp<Int64> = .copy,
        productShippingClass: NullableCopiableProp<ProductShippingClass> = .copy,
        reviewsAllowed: CopiableProp<Bool> = .copy,
        averageRating: CopiableProp<String> = .copy,
        ratingCount: CopiableProp<Int> = .copy,
        relatedIDs: CopiableProp<[Int64]> = .copy,
        upsellIDs: CopiableProp<[Int64]> = .copy,
        crossSellIDs: CopiableProp<[Int64]> = .copy,
        parentID: CopiableProp<Int64> = .copy,
        purchaseNote: NullableCopiableProp<String> = .copy,
        categories: CopiableProp<[ProductCategory]> = .copy,
        tags: CopiableProp<[ProductTag]> = .copy,
        images: CopiableProp<[ProductImage]> = .copy,
        attributes: CopiableProp<[ProductAttribute]> = .copy,
        defaultAttributes: CopiableProp<[ProductDefaultAttribute]> = .copy,
        variations: CopiableProp<[Int64]> = .copy,
        groupedProducts: CopiableProp<[Int64]> = .copy,
        menuOrder: CopiableProp<Int> = .copy,
        addOns: CopiableProp<[ProductAddOn]> = .copy
    ) -> Product {
        let siteID = siteID ?? self.siteID
        let productID = productID ?? self.productID
        let name = name ?? self.name
        let slug = slug ?? self.slug
        let permalink = permalink ?? self.permalink
        let date = date ?? self.date
        let dateCreated = dateCreated ?? self.dateCreated
        let dateModified = dateModified ?? self.dateModified
        let dateOnSaleStart = dateOnSaleStart ?? self.dateOnSaleStart
        let dateOnSaleEnd = dateOnSaleEnd ?? self.dateOnSaleEnd
        let productTypeKey = productTypeKey ?? self.productTypeKey
        let statusKey = statusKey ?? self.statusKey
        let featured = featured ?? self.featured
        let catalogVisibilityKey = catalogVisibilityKey ?? self.catalogVisibilityKey
        let fullDescription = fullDescription ?? self.fullDescription
        let shortDescription = shortDescription ?? self.shortDescription
        let sku = sku ?? self.sku
        let price = price ?? self.price
        let regularPrice = regularPrice ?? self.regularPrice
        let salePrice = salePrice ?? self.salePrice
        let onSale = onSale ?? self.onSale
        let purchasable = purchasable ?? self.purchasable
        let totalSales = totalSales ?? self.totalSales
        let virtual = virtual ?? self.virtual
        let downloadable = downloadable ?? self.downloadable
        let downloads = downloads ?? self.downloads
        let downloadLimit = downloadLimit ?? self.downloadLimit
        let downloadExpiry = downloadExpiry ?? self.downloadExpiry
        let buttonText = buttonText ?? self.buttonText
        let externalURL = externalURL ?? self.externalURL
        let taxStatusKey = taxStatusKey ?? self.taxStatusKey
        let taxClass = taxClass ?? self.taxClass
        let manageStock = manageStock ?? self.manageStock
        let stockQuantity = stockQuantity ?? self.stockQuantity
        let stockStatusKey = stockStatusKey ?? self.stockStatusKey
        let backordersKey = backordersKey ?? self.backordersKey
        let backordersAllowed = backordersAllowed ?? self.backordersAllowed
        let backordered = backordered ?? self.backordered
        let soldIndividually = soldIndividually ?? self.soldIndividually
        let weight = weight ?? self.weight
        let dimensions = dimensions ?? self.dimensions
        let shippingRequired = shippingRequired ?? self.shippingRequired
        let shippingTaxable = shippingTaxable ?? self.shippingTaxable
        let shippingClass = shippingClass ?? self.shippingClass
        let shippingClassID = shippingClassID ?? self.shippingClassID
        let productShippingClass = productShippingClass ?? self.productShippingClass
        let reviewsAllowed = reviewsAllowed ?? self.reviewsAllowed
        let averageRating = averageRating ?? self.averageRating
        let ratingCount = ratingCount ?? self.ratingCount
        let relatedIDs = relatedIDs ?? self.relatedIDs
        let upsellIDs = upsellIDs ?? self.upsellIDs
        let crossSellIDs = crossSellIDs ?? self.crossSellIDs
        let parentID = parentID ?? self.parentID
        let purchaseNote = purchaseNote ?? self.purchaseNote
        let categories = categories ?? self.categories
        let tags = tags ?? self.tags
        let images = images ?? self.images
        let attributes = attributes ?? self.attributes
        let defaultAttributes = defaultAttributes ?? self.defaultAttributes
        let variations = variations ?? self.variations
        let groupedProducts = groupedProducts ?? self.groupedProducts
        let menuOrder = menuOrder ?? self.menuOrder
        let addOns = addOns ?? self.addOns

        return Product(
            siteID: siteID,
            productID: productID,
            name: name,
            slug: slug,
            permalink: permalink,
            date: date,
            dateCreated: dateCreated,
            dateModified: dateModified,
            dateOnSaleStart: dateOnSaleStart,
            dateOnSaleEnd: dateOnSaleEnd,
            productTypeKey: productTypeKey,
            statusKey: statusKey,
            featured: featured,
            catalogVisibilityKey: catalogVisibilityKey,
            fullDescription: fullDescription,
            shortDescription: shortDescription,
            sku: sku,
            price: price,
            regularPrice: regularPrice,
            salePrice: salePrice,
            onSale: onSale,
            purchasable: purchasable,
            totalSales: totalSales,
            virtual: virtual,
            downloadable: downloadable,
            downloads: downloads,
            downloadLimit: downloadLimit,
            downloadExpiry: downloadExpiry,
            buttonText: buttonText,
            externalURL: externalURL,
            taxStatusKey: taxStatusKey,
            taxClass: taxClass,
            manageStock: manageStock,
            stockQuantity: stockQuantity,
            stockStatusKey: stockStatusKey,
            backordersKey: backordersKey,
            backordersAllowed: backordersAllowed,
            backordered: backordered,
            soldIndividually: soldIndividually,
            weight: weight,
            dimensions: dimensions,
            shippingRequired: shippingRequired,
            shippingTaxable: shippingTaxable,
            shippingClass: shippingClass,
            shippingClassID: shippingClassID,
            productShippingClass: productShippingClass,
            reviewsAllowed: reviewsAllowed,
            averageRating: averageRating,
            ratingCount: ratingCount,
            relatedIDs: relatedIDs,
            upsellIDs: upsellIDs,
            crossSellIDs: crossSellIDs,
            parentID: parentID,
            purchaseNote: purchaseNote,
            categories: categories,
            tags: tags,
            images: images,
            attributes: attributes,
            defaultAttributes: defaultAttributes,
            variations: variations,
            groupedProducts: groupedProducts,
            menuOrder: menuOrder,
            addOns: addOns
        )
    }
}

extension ProductAddOn {
    public func copy(
        type: CopiableProp<AddOnType> = .copy,
        display: CopiableProp<AddOnDisplay> = .copy,
        name: CopiableProp<String> = .copy,
        titleFormat: CopiableProp<AddOnTitleFormat> = .copy,
        descriptionEnabled: CopiableProp<Int> = .copy,
        description: CopiableProp<String> = .copy,
        required: CopiableProp<Int> = .copy,
        position: CopiableProp<Int> = .copy,
        restrictions: CopiableProp<Int> = .copy,
        restrictionsType: CopiableProp<AddOnRestrictionsType> = .copy,
        adjustPrice: CopiableProp<Int> = .copy,
        priceType: CopiableProp<AddOnPriceType> = .copy,
        price: CopiableProp<String> = .copy,
        min: CopiableProp<Int> = .copy,
        max: CopiableProp<Int> = .copy,
        options: CopiableProp<[ProductAddOnOption]> = .copy
    ) -> ProductAddOn {
        let type = type ?? self.type
        let display = display ?? self.display
        let name = name ?? self.name
        let titleFormat = titleFormat ?? self.titleFormat
        let descriptionEnabled = descriptionEnabled ?? self.descriptionEnabled
        let description = description ?? self.description
        let required = required ?? self.required
        let position = position ?? self.position
        let restrictions = restrictions ?? self.restrictions
        let restrictionsType = restrictionsType ?? self.restrictionsType
        let adjustPrice = adjustPrice ?? self.adjustPrice
        let priceType = priceType ?? self.priceType
        let price = price ?? self.price
        let min = min ?? self.min
        let max = max ?? self.max
        let options = options ?? self.options

        return ProductAddOn(
            type: type,
            display: display,
            name: name,
            titleFormat: titleFormat,
            descriptionEnabled: descriptionEnabled,
            description: description,
            required: required,
            position: position,
            restrictions: restrictions,
            restrictionsType: restrictionsType,
            adjustPrice: adjustPrice,
            priceType: priceType,
            price: price,
            min: min,
            max: max,
            options: options
        )
    }
}

extension ProductAddOnOption {
    public func copy(
        label: NullableCopiableProp<String> = .copy,
        price: NullableCopiableProp<String> = .copy,
        priceType: NullableCopiableProp<AddOnPriceType> = .copy,
        imageID: NullableCopiableProp<String> = .copy
    ) -> ProductAddOnOption {
        let label = label ?? self.label
        let price = price ?? self.price
        let priceType = priceType ?? self.priceType
        let imageID = imageID ?? self.imageID

        return ProductAddOnOption(
            label: label,
            price: price,
            priceType: priceType,
            imageID: imageID
        )
    }
}

extension ProductImage {
    public func copy(
        imageID: CopiableProp<Int64> = .copy,
        dateCreated: CopiableProp<Date> = .copy,
        dateModified: NullableCopiableProp<Date> = .copy,
        src: CopiableProp<String> = .copy,
        name: NullableCopiableProp<String> = .copy,
        alt: NullableCopiableProp<String> = .copy
    ) -> ProductImage {
        let imageID = imageID ?? self.imageID
        let dateCreated = dateCreated ?? self.dateCreated
        let dateModified = dateModified ?? self.dateModified
        let src = src ?? self.src
        let name = name ?? self.name
        let alt = alt ?? self.alt

        return ProductImage(
            imageID: imageID,
            dateCreated: dateCreated,
            dateModified: dateModified,
            src: src,
            name: name,
            alt: alt
        )
    }
}

extension ProductVariation {
    public func copy(
        siteID: CopiableProp<Int64> = .copy,
        productID: CopiableProp<Int64> = .copy,
        productVariationID: CopiableProp<Int64> = .copy,
        attributes: CopiableProp<[ProductVariationAttribute]> = .copy,
        image: NullableCopiableProp<ProductImage> = .copy,
        permalink: CopiableProp<String> = .copy,
        dateCreated: CopiableProp<Date> = .copy,
        dateModified: NullableCopiableProp<Date> = .copy,
        dateOnSaleStart: NullableCopiableProp<Date> = .copy,
        dateOnSaleEnd: NullableCopiableProp<Date> = .copy,
        status: CopiableProp<ProductStatus> = .copy,
        description: NullableCopiableProp<String> = .copy,
        sku: NullableCopiableProp<String> = .copy,
        price: CopiableProp<String> = .copy,
        regularPrice: NullableCopiableProp<String> = .copy,
        salePrice: NullableCopiableProp<String> = .copy,
        onSale: CopiableProp<Bool> = .copy,
        purchasable: CopiableProp<Bool> = .copy,
        virtual: CopiableProp<Bool> = .copy,
        downloadable: CopiableProp<Bool> = .copy,
        downloads: CopiableProp<[ProductDownload]> = .copy,
        downloadLimit: CopiableProp<Int64> = .copy,
        downloadExpiry: CopiableProp<Int64> = .copy,
        taxStatusKey: CopiableProp<String> = .copy,
        taxClass: NullableCopiableProp<String> = .copy,
        manageStock: CopiableProp<Bool> = .copy,
        stockQuantity: NullableCopiableProp<Decimal> = .copy,
        stockStatus: CopiableProp<ProductStockStatus> = .copy,
        backordersKey: CopiableProp<String> = .copy,
        backordersAllowed: CopiableProp<Bool> = .copy,
        backordered: CopiableProp<Bool> = .copy,
        weight: NullableCopiableProp<String> = .copy,
        dimensions: CopiableProp<ProductDimensions> = .copy,
        shippingClass: NullableCopiableProp<String> = .copy,
        shippingClassID: CopiableProp<Int64> = .copy,
        menuOrder: CopiableProp<Int64> = .copy
    ) -> ProductVariation {
        let siteID = siteID ?? self.siteID
        let productID = productID ?? self.productID
        let productVariationID = productVariationID ?? self.productVariationID
        let attributes = attributes ?? self.attributes
        let image = image ?? self.image
        let permalink = permalink ?? self.permalink
        let dateCreated = dateCreated ?? self.dateCreated
        let dateModified = dateModified ?? self.dateModified
        let dateOnSaleStart = dateOnSaleStart ?? self.dateOnSaleStart
        let dateOnSaleEnd = dateOnSaleEnd ?? self.dateOnSaleEnd
        let status = status ?? self.status
        let description = description ?? self.description
        let sku = sku ?? self.sku
        let price = price ?? self.price
        let regularPrice = regularPrice ?? self.regularPrice
        let salePrice = salePrice ?? self.salePrice
        let onSale = onSale ?? self.onSale
        let purchasable = purchasable ?? self.purchasable
        let virtual = virtual ?? self.virtual
        let downloadable = downloadable ?? self.downloadable
        let downloads = downloads ?? self.downloads
        let downloadLimit = downloadLimit ?? self.downloadLimit
        let downloadExpiry = downloadExpiry ?? self.downloadExpiry
        let taxStatusKey = taxStatusKey ?? self.taxStatusKey
        let taxClass = taxClass ?? self.taxClass
        let manageStock = manageStock ?? self.manageStock
        let stockQuantity = stockQuantity ?? self.stockQuantity
        let stockStatus = stockStatus ?? self.stockStatus
        let backordersKey = backordersKey ?? self.backordersKey
        let backordersAllowed = backordersAllowed ?? self.backordersAllowed
        let backordered = backordered ?? self.backordered
        let weight = weight ?? self.weight
        let dimensions = dimensions ?? self.dimensions
        let shippingClass = shippingClass ?? self.shippingClass
        let shippingClassID = shippingClassID ?? self.shippingClassID
        let menuOrder = menuOrder ?? self.menuOrder

        return ProductVariation(
            siteID: siteID,
            productID: productID,
            productVariationID: productVariationID,
            attributes: attributes,
            image: image,
            permalink: permalink,
            dateCreated: dateCreated,
            dateModified: dateModified,
            dateOnSaleStart: dateOnSaleStart,
            dateOnSaleEnd: dateOnSaleEnd,
            status: status,
            description: description,
            sku: sku,
            price: price,
            regularPrice: regularPrice,
            salePrice: salePrice,
            onSale: onSale,
            purchasable: purchasable,
            virtual: virtual,
            downloadable: downloadable,
            downloads: downloads,
            downloadLimit: downloadLimit,
            downloadExpiry: downloadExpiry,
            taxStatusKey: taxStatusKey,
            taxClass: taxClass,
            manageStock: manageStock,
            stockQuantity: stockQuantity,
            stockStatus: stockStatus,
            backordersKey: backordersKey,
            backordersAllowed: backordersAllowed,
            backordered: backordered,
            weight: weight,
            dimensions: dimensions,
            shippingClass: shippingClass,
            shippingClassID: shippingClassID,
            menuOrder: menuOrder
        )
    }
}

extension ShippingLabel {
    public func copy(
        siteID: CopiableProp<Int64> = .copy,
        orderID: CopiableProp<Int64> = .copy,
        shippingLabelID: CopiableProp<Int64> = .copy,
        carrierID: CopiableProp<String> = .copy,
        dateCreated: CopiableProp<Date> = .copy,
        packageName: CopiableProp<String> = .copy,
        rate: CopiableProp<Double> = .copy,
        currency: CopiableProp<String> = .copy,
        trackingNumber: CopiableProp<String> = .copy,
        serviceName: CopiableProp<String> = .copy,
        refundableAmount: CopiableProp<Double> = .copy,
        status: CopiableProp<ShippingLabelStatus> = .copy,
        refund: NullableCopiableProp<ShippingLabelRefund> = .copy,
        originAddress: CopiableProp<ShippingLabelAddress> = .copy,
        destinationAddress: CopiableProp<ShippingLabelAddress> = .copy,
        productIDs: CopiableProp<[Int64]> = .copy,
        productNames: CopiableProp<[String]> = .copy
    ) -> ShippingLabel {
        let siteID = siteID ?? self.siteID
        let orderID = orderID ?? self.orderID
        let shippingLabelID = shippingLabelID ?? self.shippingLabelID
        let carrierID = carrierID ?? self.carrierID
        let dateCreated = dateCreated ?? self.dateCreated
        let packageName = packageName ?? self.packageName
        let rate = rate ?? self.rate
        let currency = currency ?? self.currency
        let trackingNumber = trackingNumber ?? self.trackingNumber
        let serviceName = serviceName ?? self.serviceName
        let refundableAmount = refundableAmount ?? self.refundableAmount
        let status = status ?? self.status
        let refund = refund ?? self.refund
        let originAddress = originAddress ?? self.originAddress
        let destinationAddress = destinationAddress ?? self.destinationAddress
        let productIDs = productIDs ?? self.productIDs
        let productNames = productNames ?? self.productNames

        return ShippingLabel(
            siteID: siteID,
            orderID: orderID,
            shippingLabelID: shippingLabelID,
            carrierID: carrierID,
            dateCreated: dateCreated,
            packageName: packageName,
            rate: rate,
            currency: currency,
            trackingNumber: trackingNumber,
            serviceName: serviceName,
            refundableAmount: refundableAmount,
            status: status,
            refund: refund,
            originAddress: originAddress,
            destinationAddress: destinationAddress,
            productIDs: productIDs,
            productNames: productNames
        )
    }
}

extension ShippingLabelAddress {
    public func copy(
        company: CopiableProp<String> = .copy,
        name: CopiableProp<String> = .copy,
        phone: CopiableProp<String> = .copy,
        country: CopiableProp<String> = .copy,
        state: CopiableProp<String> = .copy,
        address1: CopiableProp<String> = .copy,
        address2: CopiableProp<String> = .copy,
        city: CopiableProp<String> = .copy,
        postcode: CopiableProp<String> = .copy
    ) -> ShippingLabelAddress {
        let company = company ?? self.company
        let name = name ?? self.name
        let phone = phone ?? self.phone
        let country = country ?? self.country
        let state = state ?? self.state
        let address1 = address1 ?? self.address1
        let address2 = address2 ?? self.address2
        let city = city ?? self.city
        let postcode = postcode ?? self.postcode

        return ShippingLabelAddress(
            company: company,
            name: name,
            phone: phone,
            country: country,
            state: state,
            address1: address1,
            address2: address2,
            city: city,
            postcode: postcode
        )
    }
}
