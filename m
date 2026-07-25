Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B702EEE9E;
	Sat, 25 Jul 2026 20:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785012266; cv=none; b=BdApxJYkKxig1FvUt6KjsE1fFCPyEP9pLHH7nx3pBg2CPvlr/+80n6Li+Q5FRUP51LCl5bWDZKda8Cg93jCciSYWKMA3VyFLWXCNQNv6/oGlCVH9o5Lk/qlqkd/baczNois09CtT+o+EwNa+eesnSTYnVZxgeBSZbxM0J0RG2GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785012266; c=relaxed/simple;
	bh=sCWfCW/WHaS4hQ0x08P5dfuJOMP/omwj0h/vxEDGcZw=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=W84nrfAPLoE9aM/fxDM524NCvlKp8M7oSfoRViDYkDL6UnzV/xb5UWW098sDakM5LbUjMIecSgHDf4HVMXgfJQvilybscVrFtW6FaYHi/2LibUu0UzlQrog6afOf0Rs62H9IElw1chmfjsfqO68ztdGnUHSYJFHwgNvDwCpRRMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U+5nelcr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U+5nelcr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F79D1F000E9;
	Sat, 25 Jul 2026 20:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785012265;
	bh=sCWfCW/WHaS4hQ0x08P5dfuJOMP/omwj0h/vxEDGcZw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=U+5nelcrQxgYdXkBlI8jhNbmius+oRnK48mvOt5H+j+WYxiLhM7aQDyXr3C/X/Dt2
	 CQq5MH14A9cGsRStNzETLitutl9fNWoSLcExAcDzkw5SFodrKGJw0YC251RYWkENtp
	 K5l0rwycntOJ+toDbhf384cQvwQ/8mr/Y4YKrFyv/dFScq9LT8fhUEmm8Wc0uvV8qq
	 a+PRiHZIWARSvIsuR9osKlAecMP55/IZKzmaWN4npzBF4soW0/tHvjeWm5yKJULGnK
	 3x0HsOR+DX/NtJmOsn1amBVFkfr0KUpGORwn7XZbUJMjRyPD87sBeq1TufUVzplcFy
	 Gi2gvzR1hKIvQ==
Date: Sat, 25 Jul 2026 10:44:24 -1000
Message-ID: <d2979268786546b957e5360a70e26f2a@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Liang Luo <luoliang@kylinos.cn>
Cc: David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>,
 sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Fix incorrect SCX_PICK_IDLE_CPU_* flag prefix in kernel-doc
In-Reply-To: <20260724080824.2483100-1-luoliang@kylinos.cn>
References: <20260724080824.2483100-1-luoliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello, Liang.

Applied to sched_ext/for-7.3.

Thanks.

--
tejun
