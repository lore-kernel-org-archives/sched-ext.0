Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961F035B136;
	Wed, 29 Apr 2026 16:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777480963; cv=none; b=CIik9+7FU8DulGPIp9u707rraK7Mr2aYiiWpxFmfp0YAyNPV3+yu0BSgtZ1Q3K5AmChDHZvmKN6Idg45C/CcYuW+vA8fI0q4CsO9clVs0okvlMQLi/3Ppr6spAW8B8Gq/I5abLh0pqk3muwtG5Q6H1aEyCC5/u24UhQNqqOQA2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777480963; c=relaxed/simple;
	bh=emCKJv1KLREP1G6mv5tfLszrC1nvA2KOcmjU9+MDEjE=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=USvp6pWanzjuIOcM4vvvYqLO3zwh3Bfrs+ginpZDU510Bio3MX3jv7fs/hsmPhlx13z4L9u2+Cn+vZLxuSS57ujwwUUDvcd08Wv2yrM4CQcjUOriIlOdTNIgHULt20V+arDtdP8w4Rpio4eNFoul2ZGvglbXGPjyQ1rRpAC+jxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r9Tl773E; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r9Tl773E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21A82C19425;
	Wed, 29 Apr 2026 16:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777480963;
	bh=emCKJv1KLREP1G6mv5tfLszrC1nvA2KOcmjU9+MDEjE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=r9Tl773EgaTB7CbleA/g0AChHThjc/kJDn8+hx0MNLjXArjLqCVOPEhsSwe8Z4tdn
	 rzMHUCCcsU7yrq1UTUXtg4JEW6VzcW5Y8mFksGDEEArRHuy02OyX7rt8WdydUOEas7
	 tyGsSnXIgjdltXLkZ9j6oxmX1uqpz7OX4pH8tpvYZCqhMBp4HTAMba2KJOselh/2pZ
	 K6Am1DdF3mHmDRLuiU4xOy2KJyO3iiA3b1g4lY8Gkd0OWlu3gdBMPAKAMLR4/6ZeQu
	 BQMK1E63fOvKAskIyEv0upXgVGq4KR9pEOtjlXZF0/8UOqXMr0AwfrziJndAyv3mZm
	 1QiMQsFygnPzA==
Date: Wed, 29 Apr 2026 06:42:42 -1000
Message-ID: <3ee3e42a6d65292a6aa3437298a06bdd@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: Changwoo Min <changwoo@igalia.com>,
 David Vernet <void@manifault.com>,
 sched-ext@lists.linux.dev,
 Emil Tsalapatis <emil@etsalapatis.com>,
 linux-kernel@vger.kernel.org,
 Cheng-Yang Chou <yphbchou0911@gmail.com>
Subject: Re: [PATCH 16/17] tools/sched_ext: scx_qmap: Port to cid-form struct_ops
In-Reply-To: <afINanPdf7IoUmJp@gpd4>
References: <20260428203545.181052-1-tj@kernel.org>
 <20260428203545.181052-17-tj@kernel.org>
 <3faf06dd-1175-4690-b97f-bb4e0b30566e@igalia.com>
 <afINanPdf7IoUmJp@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

Thanks. The qmap caller was written against a follow-up patch that
got cut from v3. v4 will fold in your fix.

Thanks.

--
tejun
