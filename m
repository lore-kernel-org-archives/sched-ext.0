Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E029F3839A1;
	Fri, 14 Aug 2026 19:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786737001; cv=none; b=kQETu4uwd/fd1Jd81UvVxR9BjZX59/u35RjhQ4joqYJvSx98myNDe1Wn/KM+/2MIxUKxGgni8FLptgSnFGJAZUI9Q9fJosoJs9xRhVOPmh0MG1bZrZCMPkw1d5FDgFFmysAkXSAIOZ9/zIy5BUL/YtQZ/vfba0NCjvP9tuq3Zic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786737001; c=relaxed/simple;
	bh=hPdNGXYgCejrSlcTNKPrDpL1CkNm5SlJZGCQEzWJfXE=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=KbjFJ8T4jMkiPRZF9HSo3nHEgu5HRObiUn7IRXnFop7lNDhxDmx8LblILaBHDBOLJvZhUxTj1lh3P/at8fgSXj4z1r48Qcd3hFUgiwtZHe/VhXRWeOQdBXao11CR6Dp8eSDboLT4RdwheGo6skh/IqdYAjtP257p67dBorckKPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jAdRhM5u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jAdRhM5u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 662711F000E9;
	Fri, 14 Aug 2026 19:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786737000;
	bh=1hylio9obtZGWte+pWH8M8ot1QqnzE3bp3EKaQRyQRw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=jAdRhM5uqAEwABrnM4AiJwVj858iG6OUQ4Jx/FzgwEbYHmyWwbT92ry47EVjfDjJV
	 NVawWyzNsWNBktCoUZXd5XpEgy1GkIux2tGTFlk1VDvS+ic7HJix0t8rGPICerDN4U
	 PmUzgW9bHgPerDPoSbkxkBOXVjDxMg9deT8UTPU25pVxrCInzqhR+dm+swon2G6wYp
	 HOr2Z5v8Kh+hPTVfCJkHf8ZQO9IMqEG/gXcGcpcuFoSxuWh4RpPLuzqSGujYpoNOYC
	 JLACdUT65v82ITS3d1tUTJ4WxTcZspDUqivweUjRdWWps2cHNi7gx9gQt6xTa2cuaY
	 E8y3Ccnd4u1Cw==
Date: Fri, 14 Aug 2026 09:49:59 -1000
Message-ID: <d828c3b8a074293f86bf423929c0e613@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Qiurong Fang <fangqiurong@kylinos.cn>
Cc: void@manifault.com, arighi@nvidia.com, changwoo@igalia.com,
    emil@etsalapatis.com, sched-ext@lists.linux.dev,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Fix scx_bpf_dsq_move_to_local___v2 compat detection
In-Reply-To: <20260811081143.578573-1-fangqiurong@kylinos.cn>
References: <20260811081143.578573-1-fangqiurong@kylinos.cn>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied to sched_ext/for-7.2-fixes with the following changes:

- Fixes: tag updated to point at 860683763ebf ("sched_ext: Add enq_flags
  to scx_bpf_dsq_move_to_local()"), the commit that's actually upstream.
  e01a940b4813 doesn't exist in the published tree.

- Cc: stable@vger.kernel.org # v7.1+ added.

- The scx_qmap paragraph replaced with a generic impact statement as
  needs_immed() doesn't exist in the applied branch.

Thanks.

--
tejun
