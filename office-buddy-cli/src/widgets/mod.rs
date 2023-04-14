pub(crate) mod time_record;
pub(crate) mod toggle_switch;

/// Something to view in the demo windows
pub trait View {
    fn ui(&mut self, ui: &mut egui::Ui);
}
