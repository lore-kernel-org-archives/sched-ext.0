Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF263E3D9E;
	Thu,  9 Jul 2026 22:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783636118; cv=none; b=FQDS5TzxbP4JH/qvPX2ExNNWURlrFpW9y8IAtJT3tzstetVrM6tsCT3Ae7QMNNQEAcLiF1BL65uSV6RF/udP1Gh3thBHCoUZBXYZOAsomeuCU4jChnJYLBL7qYAg0sgOuDeMieHiRRq2deVh/rYEqZWsnvIB9fBCzNgeNX0V028=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783636118; c=relaxed/simple;
	bh=ZdfB+igM0PX4/iraGbcK6OOcHBgqNM/va7haSned39g=;
	h=Date:Message-ID:From:To:Cc:In-Reply-To:References:Subject; b=uHlR9lpPitsDuTB+Pd5hpDUJiX5P0AGEaXe6pOVGNRMuItNzyIinnx5p3uULEkEJjARD8zZEePionLflJiHwbp9FZu3ZHgi1a3JDIHfIBYXrGyJCkUnyVqin9fUcnupXBZHT5YUU2MSya/dgMEmQ0URleC0Oy2g1o+d5BaPr7GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ljx/DkyR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ljx/DkyR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A89481F00A3D;
	Thu,  9 Jul 2026 22:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783636116;
	bh=0IX4T4mSL2QP0slobxhsVPB6GQRTcdvDlGy0BswXgq4=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=ljx/DkyRpb72vjoyEw+GxZ+3r9FCI2Vl0wH/YThGMPmqYOUhpFzzmzliC4Q8chXMD
	 Azry6uXxDBzhXlS39x7aAEZjmKWs+zSS5HR/F85qvuCZzHOHeBHfxWpXj55IX17UJr
	 sExy6RTLdHMutr8guiE1yW99YYdySCvthtBrINPYFOD1ImmPv2iRMwUJGgyRdgciEU
	 sDR/zfQhGKBVI4AlVvF/IGV1IVlj/+vf3scLNoAJ4STm+bTapydjfhvE9mk0NxxhB7
	 tzwnRFw3xf8YH26I5Q91mAxuZ+jva862WUlfGqbWgeZW1EM5hiLS/hYFnYLdbJqjBM
	 ExT1zomM3Nf8A==
Date: Thu, 09 Jul 2026 12:28:35 -1000
Message-ID: <a390925bc85675218be8eb38c8aaa408@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: sashiko-bot@kernel.org
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev, Emil Tsalapatis <emil@etsalapatis.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20260708214720.193391F000E9@smtp.kernel.org>
References: <20260708212429.3405787-1-tj@kernel.org> <20260708212429.3405787-15-tj@kernel.org> <20260708214720.193391F000E9@smtp.kernel.org>
Subject: Re: [PATCH v4 sched_ext/for-7.3 14/40] sched_ext: Defer scx_sched kobj sysfs add into the enable workfns
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

On Wed, 08 Jul 2026 21:47:19 +0000, sashiko-bot@kernel.org wrote:
> - [Medium] Meaningful code and commit message mismatch: In
> sub-schedulers, scx_sched_sysfs_add() is called before ops.init(),
> contradicting the root scheduler's behavior and the commit message's
> goal.

Intentional asymmetry: the kobj only exposes ops, events and caps, and a
sub's caps come from parent grants at runtime, not from its own
ops.init(). The pshard cmasks that caps reads are allocated and zeroed
before the sysfs add, so a pre-init read shows the truthful "no caps
yet". Root defers past ops.init() because it seeds its own caps there.
No change.

Thanks.

-- 
tejun
