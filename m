Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3160619D89E;
	Fri, 24 Apr 2026 17:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777051461; cv=none; b=FWHci1GcgPEHWiiiueuvJvKcBUTck9qAS7CcsCTmYb4fwd4RVfMMPpxt1mLV/Mu/EJ+tSsiPCKUgaxtfujfpoVTA0RYipgnJtzPJxr+qGwcMT5wu5EwXhoAomevH+rowQ+a0PubM5Z75YYjpwZBwvbdzULuKw+VHEaf4L/E3teE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777051461; c=relaxed/simple;
	bh=pTLlT8ra+c9JTq6+MgL/FKy81e42FRoa7NJHbUVz6Jk=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=snQ1MlFX1JQU3w3OC+/ReYVHiaEnPXADSUwmqTjzECHmgq4iChf4dEngdzOZW5gTuQ86E6LEiZJXPeUURhd99U/TkdYODTs8i9qFqq4fNj4MSusiT91el82q8FT0i35eCbO09X1d0FN3tVmazioalDNpJB7ksR0Zf42Cap0N8cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qSPFYpLC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qSPFYpLC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C564EC19425;
	Fri, 24 Apr 2026 17:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777051460;
	bh=pTLlT8ra+c9JTq6+MgL/FKy81e42FRoa7NJHbUVz6Jk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qSPFYpLCOPEcH9d7qvzJZvgssOegYAJdvscVyCLxKMxr7MJw9Lx1Qdm5bgkX57Vsb
	 roHA9bpGvNTa+doMdlYqUkc+ohTn+axyrU8Lp4KU4RVtCU7DtqUT5B3Zi52+S/tOK1
	 f8qA83KVOq5+rvjpFtXnGHKFU1PPKCN/x1j8KD5hhqmcgFN4UsjXKBRcnm1s18w89i
	 Q0+vVjFIk/r3MGx9nnztQZ9dpvcWwnHM1hExAX26VaEbBlOrPz5aAl8kb9rHOJ8L31
	 qSIt6qsbCsk35HzL0dfaobHm6+OjLLVx3b9qkOJkGN9pygeC2P7YKPyQAQun5HWsPK
	 vQRrv86RhdBXQ==
Date: Fri, 24 Apr 2026 07:24:19 -1000
Message-ID: <693053ccb515459c07d7d07df3a1c617@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
 emil@etsalapatis.com,
 linux-kernel@vger.kernel.org,
 Cheng-Yang Chou <yphbchou0911@gmail.com>,
 Zhao Mengmeng <zhaomzhao@126.com>
Subject: Re: [PATCHSET v2 sched_ext/for-7.2] sched_ext: Topological CPU IDs and cid-form struct_ops
In-Reply-To: <20260424013220.2923402-1-tj@kernel.org>
References: <20260424013220.2923402-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

The v2 patchset I sent out was not properly threaded - each patch went
out as a standalone top-level message instead of threading under this
cover letter. Sorry about the mess.

I'll repost v2 shortly as a proper thread with the same content.

--
tejun
