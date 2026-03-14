Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1102D8773;
	Sat, 14 Mar 2026 09:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773479093; cv=none; b=ZAiTGOJNy2a2AniLfkAfXbFdWAjIkY1YYeZIbaUlTqB1BOlfdsp6mCTUCciuoViNRAGKbjY0AtuDnKUzQiXqYjJgPcJknR5X1in9xyimk6OAZyuZj4ur8Up89X8jDgKIgAMnFmN+cDgR4x0VDWjMh+rzDvnYZSqcSfGKmrjVSlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773479093; c=relaxed/simple;
	bh=w4wWsKfgwuwyK6wLp9ak9sb2QQeWum1J2UbHniKD2xU=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=AvqNG/3cRcnjToPDgsUzNa7ZqUIhXInaWIFYLlsJ+zu9G52zP4Q67R/Sd0M+/2ZhapQZjDTw7oLVA0uV9qSn7nFhGR2VePJCEbFWhmrvvCOjbznuBygzOEA00IhDUYAcG06FoZxfEkt4N2B7WjiBsziEaj457yzYd4yydAMcXR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YGtwzb2u; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YGtwzb2u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBAF5C116C6;
	Sat, 14 Mar 2026 09:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773479092;
	bh=w4wWsKfgwuwyK6wLp9ak9sb2QQeWum1J2UbHniKD2xU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YGtwzb2uNijplMT98XDXjTBBg9/EF3V2xdsiWY2LD4pkPToF2hCl2JF11iRG8y3V+
	 5FF9yWxGimPoch2EqbZXpgnKgMdPJgIt0ktwJAeNG5joIL5Bi6dEps4gbc41jhm1hf
	 /zAsOQ+ME8cGLP4Fb7DJfYiaEcI5vjO3KEIReDHaN6jrCf+FA/VsmpC/1qYuqd9eBA
	 cQX/+md+1VP2hnllX+5MX/voOgzQ3WqxKh1rTXsefN3qmJFWUWGp2crDpqPwLMnzkv
	 C+gUds/nW5Kbx27/zfQw32xr8Y4s0kVv3DVtvTunBEBGE8OmHDFJPR3qjg0MTTrtHI
	 tbJA2b96igKkA==
Date: Fri, 13 Mar 2026 23:04:51 -1000
Message-ID: <ebe2578e7e6bee15b366c3309512fb09@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>,
 sched-ext@lists.linux.dev
Cc: void@manifault.com,
 arighi@nvidia.com,
 changwoo@igalia.com,
 jserv@ccns.ncku.edu.tw,
 chia7712@gmail.com,
 linux-kernel@vger.kernel.org,
 Emil Tsalapatis <emil@etsalapatis.com>
Subject: Re: [PATCH] sched_ext/selftests: Fix incorrect include guard
 comments
In-Reply-To: <20260314042057.29691-1-yphbchou0911@gmail.com>
References: <20260314042057.29691-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

Applied to sched_ext/for-7.1.

Thanks.
--
tejun
