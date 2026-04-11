Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DA6175A8C;
	Sat, 11 Apr 2026 02:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775875304; cv=none; b=AEPpPBOG8G+TlAiM5xBXAiE5/2ZsBwSswsnmYLLm5NHY7BmviT1AlIMhOhYJYUxIDKUFcbfDQHX/7nnyNqe+aBamga3C6LW0XH4GioR2muGhKBWcqoU/1ZS3V7TbOaTcIE+16RiTZZ6v3S0aXdg5TGUG1sKn2d53GIC1pxKU5vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775875304; c=relaxed/simple;
	bh=vgg10wisqe7411dDAz7HodeSmyWIO3xv0gW0nx7XxMA=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=qzGtJeHdQYAh8PckCj3mpsjfsazijYRIsve/cVqed60ovVfcog312qtBReQaoPJOHKtPDXp7d8bsGB8oLYGcxq0VK94xyyhVqpiFrkAyXzoJyPPOMS+Co7aiqdTmuLFp7PYVL8NN2tGa/JdklYpjZE9H6JwZJBs6TcWVe8ssijw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f2cfxMtY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f2cfxMtY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 812B9C19421;
	Sat, 11 Apr 2026 02:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775875303;
	bh=vgg10wisqe7411dDAz7HodeSmyWIO3xv0gW0nx7XxMA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=f2cfxMtYhJH0PczcPMuj89x+19ZezkCnVisDp1bTM6MjzGCIvfHPZj1IfrKn9jFfA
	 jC+85YEk4uF1WLV1IYfR0pd0Ik2sWvQ1NswpJvh4L/gjnVIgsp0SVLaqD+s5h5pa7s
	 1vCmBZTPDEN1vg8fUXL2GKS9cbkJ0bXx8fWCDkUloWGT72L7Pe3AMbAvdxNvVuIZ39
	 tlgdDLcOKu+QmpeafnGd6xlz5idEAzoM1SZbhRDT7haBKsiLob1BmVQrf5B3EDyQjV
	 BYvVVwmMzLGlcHkHf/K26WjHmdmJw2GFmsCxJ1XK7fhe6qjtCFAsccEAroP4XU36A0
	 Dh7t3EK5so95w==
Date: Fri, 10 Apr 2026 16:41:42 -1000
Message-ID: <608a841c0584ff0254036a4e08e2fa43@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Zhao mengmeng <zhaomzhao@126.com>
Cc: void@manifault.com, arighi@nvidia.com, changwoo@igalia.com,
 sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org,
 zhaomengmeng@kylinos.cn, emil@etsalapatis.com
Subject: Re: [PATCH sched_ext/for-7.1] sched_ext: Drop spurious warning
 on kick during scheduler disable
In-Reply-To: <8A8D3A99-FDE5-4DEA-B619-756F51146FDD@126.com>
References: <20260410202054.4189994-1-tj@kernel.org>
 <8A8D3A99-FDE5-4DEA-B619-756F51146FDD@126.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied to sched_ext/for-7.1 with your Reviewed-by tag.

Thanks.

--
tejun
