Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6268D3803F3;
	Mon, 12 Jan 2026 18:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768243911; cv=none; b=m9f4q23KpApR/JCx0m4cZXUqX5klaLFY+KJkFD+62LFBnZjfK/7BY2/Lwt40ImipJ5VyAj2G/ykqEBIsihwRymubUDCMNLwhk2/RXDoHSrT3GURt6GEORubS8HUvhHElxeOUsB3LNSsmqaJLXj/UE8bIrzI5y2OFkvrE8cPE9A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768243911; c=relaxed/simple;
	bh=y0ql+kArP4ZUhWWenXCaYJZ+iapODVlkzugO8Pqh/Bg=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=OK1RN2Nk1CL2vc8ZdHcpg5vsvRdV2zKsX9GBKOQAXM/qyVdrNzgidl2neaCIjpJk/YlXOh/h4NYnvl9FhNlNQv1LN3hJkLxBOV1sqRDCTQOYLz4dMf2zQwaM1JnlfxuiE397dqM+gI53mhjJ4o2qGKiqU5bUWYFy4I4bFGFHhTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=er1X/VO8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="er1X/VO8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F33ECC116D0;
	Mon, 12 Jan 2026 18:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768243911;
	bh=y0ql+kArP4ZUhWWenXCaYJZ+iapODVlkzugO8Pqh/Bg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=er1X/VO8QKP37SaetgDQv+KpzPCWEnm23K6KYbQqWHgnQfIRzquDmfFFZanEM9D36
	 V0H2vQ75xwoabcTX8k0QvVgq+fJhvKlPFj+ZJTGrdp3UbL7d/b19IjjdYYnzQ8MdS2
	 //PZkH5yxQe44jq9OVcwaByrM8c6QcBiHyL7Xy42gmweHIgi/CYSgY3ReHv/ZCW2DY
	 GZ1lhyfw7DgrJwfIg5XBBJHC/YnHsUSCW7twuDU2cap8YviK5NV8eWMq8U3+JgIelA
	 SMVL2i/hGTpK5XElav+M9mIqPhZELQc6MjcuGxsjLe/nUEcrv6p4ZR3iHJCX1rV7zC
	 PCj2KuMbk7icQ==
Date: Mon, 12 Jan 2026 08:51:49 -1000
Message-ID: <84def95f363794ba6d8d2ed920cc18d7@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: George Guo <dongtai.guo@linux.dev>
Cc: arighi@nvidia.com, changwoo@igalia.com, etsal@meta.com,
 guodongtai@kylinos.cn, linux-kernel@vger.kernel.org,
 sched-ext@lists.linux.dev, void@manifault.com
Subject: Re: [PATCH v3 1/1] sched_ext: Add error logging for dsq creation
 failures
In-Reply-To: <20260109161214.94419-1-dongtai.guo@linux.dev>
References: <20260109161214.94419-1-dongtai.guo@linux.dev>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied to sched_ext/for-6.20.

Thanks.

--
tejun
