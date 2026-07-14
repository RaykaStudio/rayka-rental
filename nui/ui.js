let currentRentalId = null;
let categoryData = [];
let categoriesEnabled = true;

window.addEventListener('message', function(event) {
    let data = event.data;
    
    if (data.action === "update3DHint") {
        let container = $("#asccochi-interact-container");
        
        if (data.visible) {
            container.css({
                top: (data.y * 100) + "%",
                left: (data.x * 100) + "%"
            }).show();
            
            if (data.showKey) { $("#asccochi-key-el").show(); } else { $("#asccochi-key-el").hide(); }
            if (data.showText) { $("#asccochi-text-el").show(); } else { $("#asccochi-text-el").hide(); }
        } else {
            container.hide();
        }
    }
    
    if (data.action === "open") {
        currentRentalId = data.rentalId;
        categoryData = data.categories;
        categoriesEnabled = data.enableCategories;
        
        $("#asccochi-interact-container").hide();
        $("#asccochi-rental-name").text(data.rentalName || "VEHICLE RENTAL");
        $("#asccochi-main-container").show();
        
        setTimeout(() => {
            $("#asccochi-main-container").addClass("active");
        }, 5);
        
        if (categoriesEnabled) {
            $("#asccochi-tabs-holder").show();
            buildTabs();
        } else {
            $("#asccochi-tabs-holder").hide();
            renderCombinedList();
        }
    }
});

function buildTabs() {
    let holder = $("#asccochi-tabs-holder");
    holder.empty();
    
    categoryData.forEach((cat, idx) => {
        let tab = $(`
            <div class="asccochi-tab ${idx === 0 ? 'active' : ''}" data-id="${idx}">
                <span>${cat.label.toUpperCase()}</span>
            </div>
        `);
        holder.append(tab);
    });
    renderList(0);
}

function renderList(idx, query = "") {
    let holder = $("#asccochi-vehicles-holder");
    holder.empty();
    if (!categoryData[idx]) return;
    createCards(categoryData[idx].vehicles, query);
}

function renderCombinedList(query = "") {
    let holder = $("#asccochi-vehicles-holder");
    holder.empty();
    let allVehicles = [];
    categoryData.forEach(cat => { if (cat.vehicles) allVehicles = allVehicles.concat(cat.vehicles); });
    createCards(allVehicles, query);
}

function createCards(vehicles, query) {
    let holder = $("#asccochi-vehicles-holder");
    vehicles.forEach(veh => {
        if (query !== "") {
            let matchName = veh.name && veh.name.toLowerCase().includes(query.toLowerCase());
            let matchBrand = veh.brand && veh.brand.toLowerCase().includes(query.toLowerCase());
            if (!matchName && !matchBrand) return;
        }
        let card = $(`
            <div class="asccochi-card">
                <div class="asccochi-left-info">
                    <div class="asccochi-img-container">
                        <img src="${veh.image}" class="asccochi-img" onerror="this.src='images/default.png';">
                    </div>
                    <div class="asccochi-meta">
                        <span class="asccochi-name">${veh.name}</span>
                        <span class="asccochi-brand">${veh.brand}</span>
                    </div>
                </div>
                <div class="asccochi-right-action">
                    <div class="asccochi-price-tag">
                        <span class="asccochi-currency">$</span>
                        <span class="asccochi-amount">${veh.price.toLocaleString()}</span>
                    </div>
                    <button class="asccochi-btn" data-model="${veh.model}" data-price="${veh.price}">RENT</button>
                </div>
            </div>
        `);
        holder.append(card);
    });
}

$(document).on('click', '.asccochi-tab', function() {
    $('.asccochi-tab').removeClass('active');
    $(this).addClass('active');
    renderList($(this).data('id'), $("#asccochi-search").val());
});

$("#asccochi-search").on('input', function() {
    let val = $(this).val();
    if (categoriesEnabled) {
        renderList($('.asccochi-tab.active').data('id') || 0, val);
    } else {
        renderCombinedList(val);
    }
});

$(document).on('click', '.asccochi-btn', function() {
    $.post(`https://${GetParentResourceName()}/rentVehicle`, JSON.stringify({
        model: $(this).data('model'),
        price: $(this).data('price'),
        rentalId: currentRentalId
    }));
    closePanel();
});

function closePanel() {
    $("#asccochi-main-container").removeClass("active");
    setTimeout(() => {
        $("#asccochi-main-container").hide();
        $.post(`https://${GetParentResourceName()}/close`, JSON.stringify({}));
    }, 280);
}

document.onkeydown = function(data) { if (data.which === 27) closePanel(); };