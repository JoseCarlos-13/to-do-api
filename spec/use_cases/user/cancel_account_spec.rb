# frozen_string_literal: true

require 'rails_helper'
# require 'support/request_helper_spec'

RSpec.describe User::CancelAccount, type: :use_case do # rubocop:disable Metrics/BlockLength
  describe "#cancel_account" do
    let (:user) { create(:user) }

    context "caso o usuário não tenha tasks assinadas para ele" do
      let (:user) { create(:user) }

      before do
        User::CancelAccount.new(user).call
      end

      it "altera o status do usuário para inativo" do
        expect(User.first.status).to eq("inactive")
      end
    end

    context "caso o usuário tenha tarefas para ele" do
      context "e o usuário tenha tarefas em andamento" do
        let (:user) do 
          user = create(:user)
          create(:task, user_id: user.id, status: "in_development")
          user
        end

        before do
          User::CancelAccount.new(user).call
        end
        
        it 'alterar o status do usuário para inativo' do
          expect(User.first.status).to eq("inactive")
        end

        it "alterar o status das tarefas para 'cancelado'" do
          expect(User.first.tasks.first.status).to eq("cancelled")
        end

        context "e o usuário não tenha tarefas em andamento" do
          let (:user) do 
            user = create(:user)
            create(:task, user_id: user.id, status: "to_do")
            user
          end
 
          before do
            User::CancelAccount.new(user).call
          end

          it 'alterar o status do usuário para inativo' do
            expect(User.first.status).to eq("inactive")
          end
        end
      end
    end
  end
end

# - Caso usuário não tenha tasks assinadas pra ele, basta modificar a coluna status de usuario de active pra inactive

# - Caso usuário tenha tasks pra ele, verificar o seguinte: recuperar todas as tarefas que não foram finalizadas 
# (ou seja: com status diferente de done) e atualizar para o status de canceled (se esse status n existir, deverá ser criado)