Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF52686347;
	Tue, 23 Dec 2025 02:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766457085; cv=none; b=K1hDAenTLuS9iQ1B2M6a38qqORc5ITxlEkvZx9NOK3kvOfmzPYhcvampGGbFqTVasCavSX2TOovPvMESSQ5KeH4gyx8KDvzJv37UGWXKn/ofHrflVZpvVQX2ZKE8NuXu7K269/aTsYgAnZlWjI6Lh4evuxTxZMlHlzZO2dtn/fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766457085; c=relaxed/simple;
	bh=lbrIanfzA3sXmf/XxrBzZeKGib+/+MV0kLuSpoUi28U=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=gdeCWD5Sk4J3PBnwFSHQsd1GCREjGyCXXiXku9txsUsUQp0utbkgEbTojhMiuv8u721IazAf3kFXA8JYoMf4G4FbvVjhdVC3KLzjbxuLn9BGn78viwCqIC6a+6qr0VN2xX2QupjShbxqAyabtxZJProt1lQpZhl9MWVqWAJUHi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nzsrPSNl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nzsrPSNl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24912C16AAE;
	Tue, 23 Dec 2025 02:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766457085;
	bh=lbrIanfzA3sXmf/XxrBzZeKGib+/+MV0kLuSpoUi28U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nzsrPSNlGpCY0TyYkvqoa/ZhnObZoAwhcE+OMpyYTlEV9KYpBT4nYBf6H3zFURQPA
	 qHEL3si4qpAnQ+09ndKSOeyHHy0uJ1hJu/qqaMG5YJ40liDc6XvsGak5S7A1W+kzrw
	 5blUrCzgryXOMn32BBuou2svR3GtNgWfzNjgQkfSnzeSsX3oRjdMNDPOaxgv84KNd7
	 NneaKIzk2RtQit9CySc4rKxyXI+evdjuUYD5GSxzujhgy11gsfGRyCMTf9IJI25jUH
	 SKf18LniTfRq0k3rrz7NMfM2tIX3pZKukMenVZuPwJNNVcpwvKJ+bEL5UmJys7TURP
	 fJ4A/krNmAQRg==
Date: Mon, 22 Dec 2025 16:31:24 -1000
Message-ID: <8333ac00663772e3645319b89ed1cc7f@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Zqiang <qiang.zhang@linux.dev>
Cc: void@manifault.com, arighi@nvidia.com, changwoo@igalia.com,
 sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Fix some comments in ext.c
In-Reply-To: <20251219093404.382-1-qiang.zhang@linux.dev>
References: <20251219093404.382-1-qiang.zhang@linux.dev>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied to sched_ext/for-6.19-fixes.

Thanks.
--
tejun
