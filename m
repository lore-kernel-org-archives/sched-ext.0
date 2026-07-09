Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CBA3E2ADA;
	Thu,  9 Jul 2026 22:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783636116; cv=none; b=leKkKyhLTrwMc6Rh/zSjkQpWHbnOoS9X+XhOt0PdMv/g6LXf/f1DkERhYuXtp/9mIg8ejZe0Gpi1056T6apJ7tKUovUZEDzgLX9U2jrEkpZsuSQ33CIP69zhMOUPlM3yV7/xz7oSv4iF+IFiwfuAQ5/Ge/tBiKwHSdPLbT1p45g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783636116; c=relaxed/simple;
	bh=u1wv/OooNpQovcjFOqxL7cxAWIlNQuouGDDtiKk4NzY=;
	h=Date:Message-ID:From:To:Cc:In-Reply-To:References:Subject; b=COjAkP+xMZLukv3C0XJ4hkAfrOYsTnWqUoqqQTmQuE/7OchvPDLTIykjEvbcJzrblduAL4NEFo3IvOfrn4CPYWoH83VkhcXBojwwICA+lazY/7qhfjdheshUtaKv22j8diG0uxObM7bkTSGKYDYKhht/eGxYB+FWppUGhKpRAk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q1yQG4Pg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q1yQG4Pg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 924DC1F00A3A;
	Thu,  9 Jul 2026 22:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783636115;
	bh=0gnBK3lo7F1UZ7Cc9u6D2SSm491g/BS0btjl/JaQqCw=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=Q1yQG4PgMfjJTA1RnZ4rLavjf3dDCd+TqcekvIeKgDHejGQiKtN6PDb9cn8oKVo1b
	 D4UffxEaElyvE9SqoXnJQMhsu69y7szhh5qPngMgcfkqdGFeGGADpDJSOLQ/BI6fgI
	 Ag8ofRDWlkyrH8gK/D2H6yXJPBmWr7VLP+GQVKArF9hktN4QiRXs0CRBCrR+TBGfjz
	 lin8Duy+vBhR0bQnIrkkPj4+/GTE3KKXxZ348YVtxiZrb7o7kl9Djhng61Qas2Q5Fn
	 1mmqqCqQfLb0Dst6fXtfgeFOy/bBtJVlxaNfAVBuGLs4aMQeX5fEPC1nOxMFMgOgt6
	 40mg8R4RQDMSw==
Date: Thu, 09 Jul 2026 12:28:34 -1000
Message-ID: <28118efd7e98e0f77ffdd93367120381@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: sashiko-bot@kernel.org
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev, Emil Tsalapatis <emil@etsalapatis.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20260708214738.7A1811F000E9@smtp.kernel.org>
References: <20260708212429.3405787-1-tj@kernel.org> <20260708212429.3405787-14-tj@kernel.org> <20260708214738.7A1811F000E9@smtp.kernel.org>
Subject: Re: [PATCH v4 sched_ext/for-7.3 13/40] sched_ext: Add shard boundaries to scx_bpf_cid_override()
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

On Wed, 08 Jul 2026 21:47:38 +0000, sashiko-bot@kernel.org wrote:
> - [Medium] Unbounded allocation sizes for kmemdup before validation
> trigger kernel warnings and allocation failures.

The __sz arguments are verifier-bounded to the size of an actual BPF
object, the kfunc is only reachable from a privileged scheduler's
init_cids, and a failed allocation lands in the existing NULL bail which
aborts the enable cleanly. Reordering wouldn't buy anything real. No
change.

Thanks.

-- 
tejun
