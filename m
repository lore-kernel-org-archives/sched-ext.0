Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15DD3BE16E;
	Wed, 25 Mar 2026 16:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774454409; cv=none; b=sxc/X6z7R5KB7Cs3IFKbs7XFex8xXGQto39lGpKQCXScLODIR0tZ4wZ0uWaQFMSds0P5sYX7kZaXIeyGYqBeCfCRXWvsUYwTlL+vuFFlrur7DPIGDN8ZoOTRSQjuhA/Yu/pd40Hm1wc2qf59S0TopR7bEc3yHYContt14RTLdxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774454409; c=relaxed/simple;
	bh=/6Uj9XwUoAPU0BcQZVOTdOUSFBimlsKmIkp3D+XTOGA=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=HnRx1kZDvE0gbN40JeM0ABxiIH3KGwlK74ZuzRMyMTcuvAjMejf2xehipizmSogLzKs0umMmzDHqzNN8bSQsUG8R1g8mF/1zfK90W+g/cJjXlIaA8A1mZZUp+sRpF7GOx54SoLyM1PQudRS1Ug7QSFisMVAJK35V4kDsHrTGJHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dASqgte4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dASqgte4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F945C116C6;
	Wed, 25 Mar 2026 16:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774454409;
	bh=/6Uj9XwUoAPU0BcQZVOTdOUSFBimlsKmIkp3D+XTOGA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dASqgte4M25hVrJyTCz2zzhPwQr3eExMrwAOOUV3P+uAElGkMHJjijcgcXxHCn5h0
	 pFDDiz/xj51lgU8RVGAXgWvM5cqSDYS07Dpm9c0YzswzaAyNoBQ5lKPHHHXUJKSKLd
	 ZfV8rL/qfDZbV7lAFByMC3Jxy+g88a71UZZBpA4L5ToAFTW9aJQuW57QJPMlmL73mX
	 9TL6i9lkHM8U9I4UtxTDbMqCGo70BduFyp8dB9AIko6394WEpbabgoOQiqcOpxW7sm
	 xWpTaaR0ntOaZuCGyUsqCccLbevVCjeZlngidGsshxruPSgOZb54PLbF92M2ljp6wZ
	 EXd4fx0KKJe+w==
Date: Wed, 25 Mar 2026 06:00:08 -1000
Message-ID: <6f6ad26cbf3abd88101d6dd60ee15da7@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>,
 sched-ext@lists.linux.dev
Cc: Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools/sched_ext: Regenerate autogen enum headers
In-Reply-To: <20260325045204.1966571-1-yphbchou0911@gmail.com>
References: <20260325045204.1966571-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied to sched_ext/for-7.1.

Thanks.

-- 
tejun
