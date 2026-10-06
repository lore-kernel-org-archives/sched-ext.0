Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D57D3812DB;
	Tue,  6 Oct 2026 20:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791318993; cv=none; b=B0G8mRqZLVtOryDW0gXmfqT/LxEeIbu8/ieRcZeplJ6GWyhtp5kN+z27dKZ9nZwR59V4HpyNU+aOhvtNR1qQAJSyWSaDFV4BrDJiWWMkhgaBJ0MZstUp10U+5DJnEmUExDwJjQj8Le6U6roRzDeRMbSAySHVe6M5xHp9FiezfDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791318993; c=relaxed/simple;
	bh=SywnkjNrx1l77EX4JF5MwnGKHxNBMWFAkKyx8M7l+X0=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=LgAmGvbh9XWeg0hNBA72Xh4SKKEPVcuWSyBpsfBoS4kVn9BBhG0H0o4F588jhEm+k18KzSG1sK6ZANWnO4dPWS2KnRmB66HA94oFezY06GaZBgITrDWcazgu4RR2W+cf2nXhndNLreuarPwW1ZmLI22+Jz7b19twTCRjuzeG4gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rp5hSjAn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rp5hSjAn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D21231F0089B;
	Tue,  6 Oct 2026 20:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791318992;
	bh=SywnkjNrx1l77EX4JF5MwnGKHxNBMWFAkKyx8M7l+X0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Rp5hSjAnlCsiwz0Ct5GyKQlh+AiZX7YSB9Iek0+uBTp8O6MKtNfpqiQnGsQ6+qYyH
	 wbKPhq4NnyvQuEO76P6A2fVqZxbIrNiDo+8MpPC339PwBEFOQw5UbLmYuoa2hL6gb7
	 Gid5GrzeUJTz741ozRDG0eFUpGQCSReHFNZ8/jnNKw7v2+qI69vuodEtrbyI10Htqn
	 JUZZbK8rsumLquq1LTl8ILa5mX5uzUB8KEPoUg5MO2/dp78QNMF9nZ7UfKbUT5cls+
	 h7V/BEePKGk0gahZ+CHvc4Q/VpRpM5nfjCJRvcI+3ksnHuW/2c3IkSrKNzImPBh31m
	 P3izL3DEEXWUg==
Date: Tue, 06 Oct 2026 10:36:31 -1000
Message-ID: <3b60aa32671f4cc9624c129ac0c63802@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: sashiko-bot@kernel.org,
	sched-ext@lists.linux.dev
Subject: Re: [PATCH 1/3] sched_ext: Add ops.sub_cid_sched_updated() to
 report the sched running on a cid
In-Reply-To: <20261005181013.43E6B1F000FF@smtp.kernel.org>
References: <20261005175520.2756986-1-tj@kernel.org>
 <20261005175520.2756986-2-tj@kernel.org>
 <20261005181013.43E6B1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

On Mon, Oct 05, 2026 at 06:10:12PM +0000, sashiko-bot@kernel.org wrote:
> Will this cause the final NONE state notification to be silently dropped for
> the last BPF scheduler unloaded?

Intended. When the count drops to zero, the sched being disabled is the only
one with the op, so it is the only possible receiver, and its tasks are
already gone with ops.exit() next. An ancestor with the op keeps the key on
and gets its notification from the loop. What the loop has to do in the last
case is clear every rq->scx.sched, which it does.

Thanks.

--
tejun
