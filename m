Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C7C42125B;
	Wed, 22 Jul 2026 18:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784743303; cv=none; b=sF0Lr6+RT16l2p3Otk1z3m3mg9w0gJ+cY/M6OB2roWtU2K3qaeeawX2YyCVkF2PP4HPs6OA8i5YZmVBL0L9ahaVuuQAdoN6GzDEtfC+LNpCCtPpXlyWbjVPstSpaTOBSZc0Wt3vT+M7QMMa93e93O3h+eUsZ1GyjjQ6wo6qEeW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784743303; c=relaxed/simple;
	bh=KZ5pVuElWMLxKUdi3/AILpiRLd/cg0pIfwsBZ3i0DXc=;
	h=Date:Message-ID:From:To:Cc:In-Reply-To:References:Subject; b=OzpFfAXQp3a36MhcrOJX2WVX6ADBmt8Yrb5FM8A9QaGx8HqxawJzbAn32ceqkY5EPXErZSysQiAbQ0HCHvd/fqN37e5SdY3VtzwAELyQ2PUl3N7YHIX+gwlEypXjU/G3jZHsbxNvP1scGKD2GxbiG64qMbLhEWCFKZN1b/fAD48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IGP2SvOj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IGP2SvOj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 184681F000E9;
	Wed, 22 Jul 2026 18:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784743301;
	bh=GjJtJ/C//C1zxdvg/J4jx5ad1DKMF58sWTBHDSw14Dc=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=IGP2SvOjITla147MHVwLnZHWdp5SrNrbbujDaILdGZrgvJaJTIzuNOB26sZZw16GB
	 dZ9jn0Tor3S/9d+jmyevHi9E1a2nHAyYgOM+QHi3hAhb3fqQH3VkWeU6VmpgHCear8
	 jjd1j/+B3/uh261qf7lq7DOC0d+AxdDlWzbzzulOuWLQ8TLmdx2ZcqE4uwcsVmp+oT
	 W0+HrOlDoMKW7cur3QDNbzJHvjQ54GeHC2aCSIxXQTET4Zxv8FSHCfyVSgDrTS8YKw
	 iYcIlYr0aBvrgGTvck6rsybdPfuwbo5V6gTnLJiTPOrTtNmm+53Th3Rhq/rvwg2+e0
	 ALoz1hTrAjWIQ==
Date: Wed, 22 Jul 2026 08:01:40 -1000
Message-ID: <4ac2d3136d774ac89919b3b41f1f8ac4@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Kuba Piecuch <jpiecuch@google.com>
Cc: Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>,
	David Vernet <void@manifault.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev
In-Reply-To: <20260722143307.2772632-1-jpiecuch@google.com>
References: <20260722143307.2772632-1-jpiecuch@google.com>
Subject: Re: [PATCH sched_ext/for-7.2-fixes] sched_ext: mark waker CPU busy
 when selected in WAKE_SYNC case
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

Applied to sched_ext/for-7.2-fixes with the subject capitalized.

Thanks.

-- 
tejun
