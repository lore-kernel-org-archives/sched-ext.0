Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6341E9906
	for <sched-ext@lists.linux.dev>; Sat,  4 Jul 2026 00:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783126467; cv=none; b=IsC/Lo/ADYB8HOn+qbAM50xkB/awyTtPHS5qUCzwyGV/30ZtrTgUxeMKXnxaNiwZ8hoU8VXeQgeAyZwKbtaj0JSi5iX4zdFNwIS7t1MZq9Q49FbVMrIAX63liylCV1nHp7PdsI0wpQOqurOfuUvKR7k81W6WHWJxfyRrM3zyRi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783126467; c=relaxed/simple;
	bh=aYNfVX95EP7CBepFDUAf37ReDskvHHJedr/N1vrf1G8=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=mt05j7pldEdXpVEoLGmKCkInLAglwuwFaJMY9e1JcVs7No5pKYetcTZWnNNUjd31mt2uJA5efpPCa08mDXY39/M3VlCOqgVfaWzOrE29tyYd+cRfiXazOoKep4PGEe3ab0416g3YUBOWbdcgOxRq57dCn71aIgzs5F89AoeIqpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UzTynAZ7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UzTynAZ7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 987671F000E9;
	Sat,  4 Jul 2026 00:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783126466;
	bh=aYNfVX95EP7CBepFDUAf37ReDskvHHJedr/N1vrf1G8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=UzTynAZ74PiFX3lAIEE8IjiX4/AY5hgxHkiqlsunwVjmW+F1xpDmzfgCQTsfvrsnq
	 UJm7s1gnPuDAaciF/543c33bjL5MTl+y3jLQFWYoD5sj3qkcBzbWeYa85iB1HmhvLT
	 KNQcLdGPQB5vhacL3PtznNzYpxQniphGGgOI39f8M5dIygg1bX4YFqz0bZLoGjBmRy
	 fOrQ8D/rNREnnHbSn57qPYkSgTuUSXtfrsMiDxRTi138UwPC0zlGklpCz6R6W4w+ts
	 KabRxJFUvQvUM80JoJH8V+5xOd0AzVgJ85HWfkPWy6OqKi6zYohWVBs5HnzZ14zYYt
	 ew/IyzFt2q2fA==
Date: Fri, 03 Jul 2026 14:54:26 -1000
Message-ID: <dadfebfc5a9aad96b9a0118baa2826cd@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: sashiko-bot@kernel.org
Cc: sched-ext@lists.linux.dev
Subject: Re: [PATCH sched_ext/for-7.3 10/32] sched_ext: Add shard boundaries to scx_bpf_cid_override()
In-Reply-To: <20260703095118.6102F1F000E9@smtp.kernel.org>
References: <20260703080159.2314350-1-tj@kernel.org> <20260703080159.2314350-11-tj@kernel.org> <20260703095118.6102F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

> [Critical] Concurrent modification of userspace/BPF-accessible arrays
> `cpu_to_cid` and `shard_start` bypasses validation and leads to
> out-of-bounds writes.

On the TOCTOU: v2 will snapshot cpu_to_cid[] and shard_start[] and
validate/use the copies, so a concurrent mutation can't drive an
out-of-bounds write.

> [High] Changing the signature of `scx_bpf_cid_override` without
> renaming the kfunc breaks backward compatibility and `compat.bpf.h`
> versioning, unconditionally causing load failures on older kernels.

On the signature change: scx_bpf_cid_override() ships in v7.2 and its
signature changes in v7.3. That's fine here - the interface isn't
expected to be in use yet, and the feature is still experimental and
under active development.

Thanks.
