describe Fastlane::Actions::UserDefaultSetAction do
  describe '#run' do
    it 'prints a message' do
      expect(Fastlane::UI).to receive(:message).with("The user_default_set plugin is working!")

      Fastlane::Actions::UserDefaultSetAction.run(nil)
    end
  end
end
