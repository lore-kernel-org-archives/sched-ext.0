Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED162D7DC5;
	Fri, 14 Nov 2025 21:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763154947; cv=none; b=l4u3nk2sBN71XsotxnTSioxBOjqZZsuCvx2974icBlgEqdWC2TP1GS2+WBVjAefw08B7XgBMQUd+s6Mp5CWfBrbtKaih5buwC7uFIy0qh4qlMMSKzZ1uJcEXntMqIxqlT5AzPPrg60NAkfabGM+R4alNkf9eG1i1swK37LRRvOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763154947; c=relaxed/simple;
	bh=KlxQwxQiOyaOmfqlFrMqSOenDkOWYeInFu7SxGIC7qI=;
	h=Date:Message-ID:From:To:Cc:Cc:Cc:Cc:Subject:In-Reply-To:
	 References; b=ttiirkgELj7TFv5bIhtboxgunWs9DGLXw1TNK2stxDO2UzDLKttSaLedYNfcFzxTSKeRZ7N/aJCv61GPsDl0oyiBRJ1ztIlS86x4BkyTwMblq+JC+Oftwg3ebWYrvEEe7paEl6ZpJ2Yk8SIIsB7TaevG1jSpc+cvGiF4yqUiy4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aH7QzcQv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aH7QzcQv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B7B0C113D0;
	Fri, 14 Nov 2025 21:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763154946;
	bh=KlxQwxQiOyaOmfqlFrMqSOenDkOWYeInFu7SxGIC7qI=;
	h=Date:From:To:Cc:Cc:Cc:Cc:Subject:In-Reply-To:References:From;
	b=aH7QzcQvWzTNHFtmM4rT/jNQuhw9wQ/G1B6AeCqcroIVVn0thInR8w8+qj0JMzYGs
	 qKYX7l2B2Q76nrUzga3i7MTWbHCPWYYwALri7jswIasM8+jwa+J7MpTsuBaEa6xtSi
	 NsPZ8Zd+HsySjGgtdsUGI2cQvu7SpBHoYNsH/DZlogowCDJTJe1OVxhy37cdGnK60g
	 ipdTdF99p6KBFDjADc7QU+QWD1v8V9SO+g/x1Dw/vTDf3TYmNd9Wfy7V73QHNAKg4u
	 shlnCJh4JO/ymOQYV5rvni82npJ3dtf5hLVLREkgNAVSKZalp0F7Y5UE0gSM1/adce
	 rhzat/ysB6IsA==
Date: Fri, 14 Nov 2025 11:15:45 -1000
Message-ID: <7811087a55afbd4fb824c2e8479f2bc2@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Douglas Anderson <dianders@chromium.org>
Cc: Andrea Righi <arighi@nvidia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>
Cc: sched-ext@lists.linux.dev
Subject: Re: [PATCH sched_ext/for-6.19] sched_ext: Pass locked CPU parameter to scx_hardlockup() and add docs
In-Reply-To: <aRaG9X9xfS_QL2QF@slm.duckdns.org>
References: <aRaG9X9xfS_QL2QF@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied to sched_ext/for-6.19.

Thanks.
--
tejun
