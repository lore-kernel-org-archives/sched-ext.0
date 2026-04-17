Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650813314BF
	for <sched-ext@lists.linux.dev>; Fri, 17 Apr 2026 18:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776452022; cv=none; b=sQnk/B5bZa6oNe1AM/Nquk9OQyoDRF6u4h6fr4cDBTqynk+vo0PgRLCODk5ndaw8keWDPMn2llQRA+za2OiiEd0ewyd3Kd2opjFrT6Qt58xLDD8v51NzreWeFKXZHQ2i+uLHnKHEFsdEBIDHpztdSnTqIpqkUbkrWomn4/wftgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776452022; c=relaxed/simple;
	bh=hOTwRqZqXHWalDYqTaTPhP7JCA7xMhlGoTt+dLL+lnU=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=Pt14BCWUw9cs1KmxOcHBQg967ZuzEbjKQXcO43D4EbSS8k7E0HayYTg+PYtGuqzgTwScfKf1PBLjiaUsQgE5DxY+9PjO8+rlr6WKvFIs0OemN6lQ0wn8PJ6/vWUA50VwbQfY5gajDveHiQsePKmXvVeUwb1Q6LGNSzQjlMTeYxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kXFpjrQq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kXFpjrQq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0000C19425;
	Fri, 17 Apr 2026 18:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776452022;
	bh=hOTwRqZqXHWalDYqTaTPhP7JCA7xMhlGoTt+dLL+lnU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kXFpjrQqnIn5VpAD6mo6DXwDF3ygunB1LTJz7Iu2WsWOfYINw1nupdgHJMM8QMzPd
	 ZoReLAp9pjRA7BHf7m1K/OTHQpgFKCcCrzRvZC4vhptzGbesQfaFeyCsl+ZXCYwuVR
	 I+x6IQjdxmbbK8FH1yauUbIFHaYtRS+ZJgrWLzc7GXBC9FzClr27nDjz2wG/JU2pKT
	 lvSlN9Dn6ZozD2scmlP2wq7BSt5Vazd6Mz5MpHHwyrt8cmquYJ7RX03LnY67fo6a/9
	 XnIoiYXbJ3JTLOuoKIukPcE5sYJGsNlHWGPbICns9/80JyggVJXEXWLhO81o9+A7As
	 29kpQjlUhxZYQ==
Date: Fri, 17 Apr 2026 08:53:40 -1000
Message-ID: <c95fdfc9fcd55fe5323ae2d8d46fa274@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
Cc: sched-ext@lists.linux.dev, David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>,
 Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
 Chia-Ping Tsai <chia7712@gmail.com>
Subject: Re: [PATCH 1/2] sched_ext: Deny SCX kfuncs to non-SCX struct_ops
 programs
In-Reply-To: <20260416064715.1008437-2-yphbchou0911@gmail.com>
References: <20260416064715.1008437-1-yphbchou0911@gmail.com>
 <20260416064715.1008437-2-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

A few things:

scx_kfunc_set_idle (ext_idle.c) isn't covered by the patch. Its kfuncs
(scx_bpf_cpu_node(), scx_bpf_get_idle_cpumask(), scx_bpf_pick_idle_cpu()
etc.) also call scx_prog_sched(aux) and hit the same OOB pattern on
non-SCX struct_ops programs. Please add an in_idle check in the filter
and treat it the same as in_any.

Separately, please also set .filter on scx_kfunc_set_idle itself. In
practice, the BPF core dedups filters per hook in
btf_populate_kfunc_set(), so the filter is already invoked for idle
kfuncs via the other sets' registrations on the same hook. But it's
confusing to read the code without setting .filter on every set.

The following line is too long - please break and indent (it gets
longer still once in_idle is added):

> +	if (!(in_unlocked || in_select_cpu || in_enqueue || in_dispatch || in_cpu_release || in_any))

Once idle is covered, every SCX kfunc set ends up in this "context-
sensitive" list. At that point "context-sensitive" no longer
distinguishes anything - it just means "SCX kfuncs". Please update the
function-level comment and the two inline comments ("Not a context-
sensitive kfunc - allow." and "Non-SCX struct_ops: context-sensitive
kfuncs are not permitted.") to drop the term and talk about SCX kfuncs
directly.

Thanks.

--
tejun
