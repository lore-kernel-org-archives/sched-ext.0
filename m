Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83B04B0483;
	Sat, 15 Aug 2026 09:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786786527; cv=none; b=cd23o/pYKkZw7LSFb373cDKiK/4kMlXa9SgIP0TZJKmejq3oysVa8bCHTTDHL/zT3tRjSPlJ7t611hl0tYGZmNsZmsd4ZtkKKoAkLfLsrHmJ3IG57e1ojCjKE6fDAn57PIL0xp7mFqJ5G50fJyNiyWWmVCDjgkBNXBozcj94TpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786786527; c=relaxed/simple;
	bh=Kavl+59kgtFCYXQXpMXyb5XH15mvjyJKF+dcCHJ+7RQ=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=hwqHALXDGbm5nWQArbPovECpIYOA8qBfqKPtje1/mPI+WeDNVgLAOgB9w2l2BxupfLjbI4ROY7YthwILyRoMKE0JDvq8Wsrq4XN7n+u/18881X4CIzceH7t+KT1Vhp5r3ncINC7yyEXnxKkZiQfpg3WNlpunlT13t6IRnscPh6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pzk0ieAV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pzk0ieAV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C4E41F000E9;
	Sat, 15 Aug 2026 09:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786786526;
	bh=BsxeFdMkikWusc5Dce5wEA13m5mLEXdd68VTZnlY8/4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Pzk0ieAV0CHpD5P1sTIHU1uYqbuFozyBxiZZFH0DGmQuuRM7djxy99MhCr5jZ5a10
	 UzIXfMuf2+XG1TdjFZ4RFKzFRJyEjR92HhHDXwil5VfKAwe9qHPKLpWJL2I0lDDiyB
	 ynsUJuDu98ho3l/uvo5fHEECC44Mj8S/Y5HZImygz2eQshCmvnccS3ja7uY0d1C8so
	 nxyKVUlnVHnqHR53Lxt2YrHG1faadmUKov6/KCRC+U3Fh6uMKsw8edJ1azHxjvBXMI
	 Iz44OQ7OiXEXTdY3tdJlOXjVpyNh5egseKzRpWDaI3T0mGlVLOTOtFzFqrwaYFh80O
	 Md4Wqvd8DuE8g==
Date: Fri, 14 Aug 2026 23:35:25 -1000
Message-ID: <db213c23e9faf8f5871bd0307fbd97e5@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: sched-ext@lists.linux.dev
Subject: Re: [PATCH 2/2] sched_ext: Make scx_bpf_events() read the calling
 scheduler's counters
In-Reply-To: <20260815060403.0C69F1F000E9@smtp.kernel.org>
References: <20260815055107.115671-1-tj@kernel.org>
 <20260815055107.115671-3-tj@kernel.org>
 <20260815060403.0C69F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

> If a BPF_PROG_TYPE_TRACING or BPF_PROG_TYPE_SYSCALL program is associated
> with a different struct_ops map (like tcp_congestion_ops), the pointer is
> blindly cast to struct sched_ext_ops *.
>
> Since struct sched_ext_ops is much larger than other struct_ops structures,
> reading ops->priv could read memory well past the end of the map allocation
> and cause a kernel panic when the garbage value is dereferenced as a
> struct scx_sched *.

The hole exists but reaching it requires the privileged userspace to
deliberately associate its own tracing or syscall program with a wrong type
of struct_ops map and then call SCX kfuncs from it. Association is an
explicit per-program operation, so this can't happen accidentally. The
right fix is rejecting the association of a program which uses SCX kfuncs
with a non-sched_ext struct_ops map at association time, which the
association path has enough information to do. Will worry about it later.

Thanks.

-- 
tejun
