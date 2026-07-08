Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336383CF047;
	Wed,  8 Jul 2026 19:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783537782; cv=none; b=K8UAfP55IARZdKt/vbLkh18qv5LX6Nmp1ui6piY7CiY3edF3gJpDJyQM6YqEgwY37AtmeoVTi11PNwFTlvkpodMiww9GV5sNkbCriB/G3UmS2QQoJ1bWmPHAKHQiN4eRas7rGH7LpwfPCh5FgM+mMKR9rvGe08KAR5cYQ5exGDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783537782; c=relaxed/simple;
	bh=/ILvDbmeqjme/4SKQEnu81xZQRhA/fxxXFEAK26oQBU=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=lPc93sqZPFJJ41d1l3oufDEt+KiNf87V/faUpsGFjzFfwBrC1BI+3OygEml5kJTB96u4NyPyDDnOQtH3MQ6jPqNp84lxeN+Lqu7IljjL77muhmgGq0th5HAoZDLvqypEFr/1+G7w9RSJGn5+Q1M7f5F9VwySWz2v4pnSc0FPHsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dez36B7K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dez36B7K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C72C1F00A3A;
	Wed,  8 Jul 2026 19:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783537778;
	bh=//boj5j4V2t1Hjcqc/RFtd+HP8hLzjRepdYVr4yfFqY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=dez36B7K5QPqEYix/pe1wnzq7BkN7wl0LVKm/OwHT8QsjSuY/UOj/D4qO3IZHoC1j
	 fTK6SZIPXowziPya5Kth3yDo+p9wbvv4COqUcpMNCSawc1mRP0jqIQmXfEeEyt0RGD
	 9Fb0mGXTw6IvtcRdwBAgwxFiKFezWiO5f6ZpvXuS4x22g+qfSEGpyIXUD8++IGGg/0
	 TcdOSmcvFyxm90Vxbc9xAcdWmIrjIuMrhLemN0CfbLldSmoSBMfQQ1IeEi6KSQO0Jm
	 YXS1l5qi1GvhK4E7KTYmsPbNaOX+SVcTLoGdcCnUZVBDfPz/pCqe+3OioQYBG/AhtP
	 /1OuG+3k7PPgw==
Date: Wed, 08 Jul 2026 09:09:37 -1000
Message-ID: <d302edb6cfe897543505d691705e9ea9@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: sashiko-bot@kernel.org
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 sched_ext/for-7.3 20/36] sched_ext: Add coalescing sub_caps_updated() notifier for sub-schedulers
In-Reply-To: <20260707003307.C6C271F000E9@smtp.kernel.org>
References: <20260707001229.1410929-1-tj@kernel.org> <20260707001229.1410929-21-tj@kernel.org> <20260707003307.C6C271F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

On Tue, 07 Jul 2026 00:33:07 +0000, sashiko-bot@kernel.org wrote:
> - [High] NULL pointer dereference in scx_bpf_sub_grant() and scx_bpf_sub_revoke() when a sub-scheduler is not a cid-form scheduler.

Sub-schedulers are always cid-form with an arena pool (enforced at
attach), and their pshards are allocated before the sched is published,
so grant/revoke never observe a NULL or non-cid-form sched. Same as the
v2 round. No change.

Thanks.

-- 
tejun
