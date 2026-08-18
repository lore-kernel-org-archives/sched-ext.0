Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD72947DD78;
	Tue, 18 Aug 2026 18:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787078539; cv=none; b=ByXetHqQEgQ9pPyZITjYr/wu0hNoDu4+pbhxfzhOK2O3fu1AXFX5LvfWMesx5o8xNRNXiNZNk8H1+fN3S2Ry7PH4VcL5ugycSOvnDxppZX7U6E6boY35PHR90VrNwrFUgRH7Gt5r3r8N2UMiEIcMsgqZVgvUhRw4We5KlDq0Tu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787078539; c=relaxed/simple;
	bh=/Kw+r8/b7OHTh6jKMgHll+Ju6/nlABuGk3bbFaqaiDU=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=LygBMMYAmngSGdQbPnZH1Pc+mIGhrFU8z5BhtJpJ7ceM/uVu1qqs7tyjHxd3v8rsjdpHdo2KDtczcjUIYFU5Avftuh4Jssud3lRTW5L2nHTvzyFYTBV16xf8EJLs+JkvKe5Wsdz9sv6/hTAWNRaMXuiN/12H4F/dUkIaHXKKAoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TOzRDRy+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TOzRDRy+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 446E91F000E9;
	Tue, 18 Aug 2026 18:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787078538;
	bh=/Kw+r8/b7OHTh6jKMgHll+Ju6/nlABuGk3bbFaqaiDU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=TOzRDRy+bpqf3WyZUjiTdjbc0uxDyR/KwfHX3anYuN1Vurp2Bjd2wRxzQTyymNwyv
	 1d/gAIIkZnwTDBPj+Gxt/0kzSKHq3NAxaDvCWYyBVNsBAl+pFSUEptQcUjAcfaPRqa
	 r35ZbLDSXXTSpwkjc/RL6jLnvbD8envnpP0QSfRF2BPbwgxJqIMbRFOfGLZcXPECXQ
	 ZTA9pYSehUo8mHvL3GPcwfllM3orkZjOqTZHKxHATlCPXt1css9uw1vM14IecKtzmz
	 LcxXRZNB5Qrbi0q83JWUNlJ+tDu5+G2d4uOrjZ1IhzQLxKEfSzm+a+JMXu4xzP2WMg
	 HSsvZloMqjGGw==
Date: Tue, 18 Aug 2026 08:42:17 -1000
Message-ID: <70c140870178b9bbf37456ed58959aa6@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Changwoo Min <changwoo@igalia.com>
Cc: void@manifault.com, arighi@nvidia.com, emil@etsalapatis.com,
	kernel-dev@igalia.com, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched_ext: allow ops.cgroup_set_bandwidth() to be
 sleepable
In-Reply-To: <20260818160429.932265-1-changwoo@igalia.com>
References: <20260818160429.932265-1-changwoo@igalia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

On Wed, Aug 19, 2026 at 01:04:29AM +0900, Changwoo Min wrote:
> ops.cgroup_set_bandwidth() is delivered from scx_group_set_bandwidth(),
> which runs from the cpu.max cgroup interface write path (tg_set_bandwidth())
> in process context. scx_group_set_bandwidth() holds
> percpu_down_read(&scx_cgroup_ops_rwsem), whose read side may sleep.
> The call site is therefore sleepable, like ops.cgroup_init().

Applied to sched_ext/for-7.3-fixes with the subject capitalization fixed.

Thanks.

--
tejun
