Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436673BFAD1
	for <sched-ext@lists.linux.dev>; Mon,  6 Jul 2026 23:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783381254; cv=none; b=Gd+JeeEUc1TnSScWaM1Iz/w8ab3OzGMn2Aa0iNe759dawdfFvQ6b6M1f5gTpzbH60XPqQPIh97xTZavJ581xxrwpczY3LFXPps8CRf/sULZGU+f4LwuGF2cIKtC/7qw/vQGhp1XR/GXVmRtY/OODu6O5dOFf4YlQkqiu4w2SrdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783381254; c=relaxed/simple;
	bh=g5cODdKmVQ+iuw42TM7AD73QC/y1dq5bS4xzZfK7+Mo=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=bAkVjBk6VxJQCYP60jpR8dDIaCmHd0+FS9xJJHM1d+aG+qcm7idbpr4qFfwLRh6SPyl7NYsdEo/7FL7G078zHBYdO/tdLix5mImRBIHe9HSOC38R64XoQxlz9h46MFExFdoT7f3JyXV46LRNC+j35pH3SNtgMXbLX6o6iqNCRVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OJVzy53u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OJVzy53u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED7E81F00A3A;
	Mon,  6 Jul 2026 23:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783381253;
	bh=g5cODdKmVQ+iuw42TM7AD73QC/y1dq5bS4xzZfK7+Mo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=OJVzy53uNrBQkX9HKZ3Bb4uUX2UwuPmdm/4E67hQOUkAuW2NeoYXOqW31Kyx3nYTn
	 O0nP7XHVHDUf8CQsz4QYQk+V9E6p45ey4Dme526PbBF3k63QMGVWUGJcAAy+pCBoKQ
	 d1uJiGk5CcJ3robWm29N7oiEP1T8/sb6PB+/8zYJag+CM0R1oWikFquVX1Zib/JUc7
	 P/Ckr1olPnZ1rK+Pm1S2awGxK/RlLXYW+PliVgk7jgiC+wDGCRRxysGR2sKJzKppf+
	 HM5eUwEbVazoRF5Ifl6HLPQr0YHI02HlU1z02/PAzhecm6NDjFn+JcikQVg7k5FLQ4
	 TWCzTme40EtBw==
Date: Mon, 06 Jul 2026 13:40:52 -1000
Message-ID: <a7906b21d8b5a84f09f4b33ee567fe4a@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: sashiko-bot@kernel.org
Cc: sched-ext@lists.linux.dev
Subject: Re: [PATCH v2 sched_ext/for-7.3 33/36] sched_ext: Replay ecaps notifications suppressed by bypass
In-Reply-To: <20260706021106.007E11F000E9@smtp.kernel.org>
References: <20260706014058.439853-1-tj@kernel.org> <20260706014058.439853-34-tj@kernel.org> <20260706021106.007E11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

On Mon, 06 Jul 2026 02:11:04 +0000, sashiko-bot wrote:
> - [High] Sub-schedulers without an arena map will cause NULL pointer dereferences on CPU hotplug and capability grants because `sch->pshard` is never allocated.

False positive. A sub-scheduler must be cid-form, and cid-form requires an
arena at load, so sch->pshard is always allocated; the deref is also level > 0
gated.
