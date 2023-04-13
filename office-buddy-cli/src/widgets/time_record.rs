use crate::widgets::View;
use egui::Ui;

pub struct TimeRecordWidget {
    data: Vec<String>,
}

impl Default for TimeRecordWidget {
    fn default() -> Self {
        Self { data: vec![] }
    }
}

impl View for TimeRecordWidget {
    fn ui(&mut self, ui: &mut Ui) {
        ui.horizontal(|ui| {
            ui.collapsing("Click to see what is hidden!", |ui| {
                ui.label("Not much, as it turns out");
            });
            ui.label("(奶粉: 170)");
        });
    }
}
