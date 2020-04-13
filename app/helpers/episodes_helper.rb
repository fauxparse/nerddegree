module EpisodesHelper
  def presigned_post(where = 'episodes')
    S3_BUCKET.presigned_post(
      key: "#{where}/#{SecureRandom.uuid}/${filename}",
      success_action_status: 201,
      acl: :public_read
    )
  end
end
