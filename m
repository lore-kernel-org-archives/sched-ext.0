Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A683B9DAC;
	Mon, 31 Aug 2026 21:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788213165; cv=none; b=lbwUhSKSCfAmLHbzQiqRCBEqRLlA189xe/CQudvFPeOpL+qvilN7jpHJ8ipp/Hs/r9Lj4yEY4NIB+2/Gp+JXR/NfPlwuJDhkeA6lyL5WxXOKY5eJ9B18F88Ovf3U+Nz5eJdvYhDTqCENpgMq8lNDSdFil229mCtDK5nfi0zEHb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788213165; c=relaxed/simple;
	bh=CQbcXzwlxETc7bAjMo4f8A53oopuim2SpvHBmNRV0vY=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=SRSv1Xas6l1fSN5q51HMjMEvaEMohPix3IR0ivMeYUNw13xh8tEWusLff6R/AuPM3JXP5POQtXc0CiHSrsEDtvRsnzI3/GsKjEQmL6mdJzf2fFONyV+BgIbm3yIJY1WmfbmhfoWi8P9XZGnvhWMx3gBlWIDHXIVUHqh0qICvTRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XlYwvxDt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XlYwvxDt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 400A81F000E9;
	Mon, 31 Aug 2026 21:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788213160;
	bh=CQbcXzwlxETc7bAjMo4f8A53oopuim2SpvHBmNRV0vY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=XlYwvxDtp/x/CO08CA1IfQ0qzEoRNwDbq3kaPpkkgSb9TbSxJNRdb1l/5aYf9q524
	 Dxf8rNdpYav6guPZ0/s+ZG5u+FW6Se/fEDZvHod9+t5Osc8Ky2U30mIpwnilhSeAtQ
	 S9sMtoI2UXDzUGmQdvAJrFbiNXhj5xRZL+rgEEEAOhEBsEb9+YeP9KfiUJFbPovqPv
	 wnEbhnND5+JJYpszP819ttkiSiZvsvUWukOy/xDZV/VowtDsjBb47b46aIFtqab4+m
	 a45EwxFcuBYwLd5//4GM7lU19cENvWSqJJaL9toPDAxs/D8Kb1WofvkkRlICHUZcRi
	 Ilzv8m8xjFRaw==
Date: Mon, 31 Aug 2026 11:52:39 -1000
Message-ID: <d6cfdbdd795ef5b4c546fa8eddc6ad23@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Carlier <devnexen@gmail.com>
Cc: sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	changwoo@igalia.com
Subject: Re: [PATCH] tools/sched_ext: Extend the prolog migration probe to cid-form schedulers
In-Reply-To: <20260829122035.58018-1-devnexen@gmail.com>
References: <20260829122035.58018-1-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

On Sat, Aug 29, 2026 at 01:20:35PM +0100, David Carlier wrote:
> scx_lib_init_probe hooks bpf_scx_reg(), which is where a cpu-form
> scheduler enters the kernel when its struct_ops link is created. A
> cid-form scheduler comes in elsewhere: bpf_sched_ext_ops_cid points .reg
> at bpf_scx_reg_cid(), a separate function, so the probe never fires and
> the flag it is meant to set keeps whatever it was compiled with.

Let's keep the updates flowing through the scx repo - the kernel copies
are synced from it periodically. Can you apply the changes there? Note
that the default flip already landed there as 888a907d84b5 ("common.bpf.h:
default __scx_prolog_disables_migration to false").

Thanks.

--
tejun
