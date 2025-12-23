Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410B634B1B0
	for <sched-ext@lists.linux.dev>; Tue, 23 Dec 2025 20:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766521793; cv=none; b=tX5FGwVX2jWgbDQ5PC4QyV0BJdc4p2Zu8LNXO91VB72XZyyXQwjQcNidO24BEX2nqA8/oc1HhS+QtkjTNp8RuFmN49cmfrlT6BWQlLHCtP2DyscuPL2oYw0OOx5RVeSQv6xdK7QsQ+euhMipBUCB6chN+j26B4EFJpuxwFKaKY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766521793; c=relaxed/simple;
	bh=XY1GBEfOkt7cyyiWEIqL0ioNCbeDyHhQ9DoJhp5Hy44=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iTapOmxfrbgQmslmtNcBt2HxQuVaXMHZ0MNL/WNJteBNEXd5AYY06SdAxMz1+h6tDm7peaAV9u+IlsIxFaZO1tYIq3TEO22OUMXJbarsyH8pC9G8zQH67s7UQup53GA+PFBfq+Uguj09ExFBje6zLzHykyrn/VDNbvifWMF2gx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf18.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id CFCC513B326;
	Tue, 23 Dec 2025 20:29:48 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf18.hostedemail.com (Postfix) with ESMTPA id B9B8731;
	Tue, 23 Dec 2025 20:29:45 +0000 (UTC)
Date: Tue, 23 Dec 2025 15:31:36 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: Tejun Heo <tj@kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, David Vernet <void@manifault.com>, Andrea
 Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, Ingo Molnar
 <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Juri Lelli
 <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall
 <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin Schneider
 <vschneid@redhat.com>, "sched-ext@lists.linux.dev"
 <sched-ext@lists.linux.dev>
Subject: Re: [RFT] sched_ext: Skip stack trace capture in NMI context
Message-ID: <20251223153136.761d99af@gandalf.local.home>
In-Reply-To: <9D417792-A0A8-44C4-884B-A3406D2E7A1D@nvidia.com>
References: <20251223005038.62406-1-joelagnelf@nvidia.com>
	<aUoCBVhHig737uKt@slm.duckdns.org>
	<9D417792-A0A8-44C4-884B-A3406D2E7A1D@nvidia.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 8hx7m3exn9q3ermr9wi4fb6njkcwwpdt
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: B9B8731
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19NYewJ9l3whWdfR30yrXMzQUcU4xoOkwI=
X-HE-Tag: 1766521785-72455
X-HE-Meta: U2FsdGVkX1/93CbDgJEDcfAXOZpneBlLP614JZ6q/h2um1ltwCWfVxOlZx8DxFgCFWzjUi+dDD7mdGgYM+1agAvcq8x6gDuT07wjl1UpKtWc1LoqrXzi/FaLH/GixoxU8fS6AxD5/HdCiIt62RNrsvfdC/ukNdDRB9W+7RPYhO/jOo5r8OMvfJae/mxx2tlB6WrjHZAQwZPDcwZHz80pxmYXG8D+5A29W+tqYRHyd3tgvpTtzkcBw3UxhVfX65ajmjz6UicLGPXKiU6zvWo2IpgqYjDZ3l0Zt23EHKo5vjDrigF/HAQnyHBAWBHdWz1Z0i6Qx0QPwo0am1EqsTOMjLcuZFTM2Y4J

On Tue, 23 Dec 2025 04:34:00 +0000
Joel Fernandes <joelagnelf@nvidia.com> wrote:

> > This does work on x86 (right?) and is useful in understanding what the
> > underlying problem is. It'd be great if there's a config flag we can test
> > but if not can we specifically exclude archs which are known to not work?  
> 
> You are right that we will miss out on architectures where this is safe.
> We should make it more specific. I am wondering if Steven Rostedt has any
> thoughts here since he is actively working on stack tracing/unwinding and
> has made similar commits in the past where he restricted stack tracing in
> an NMI context.

[ Fixes line wrap, ug it's hard to read emails that go across 300 characters! ]

Well, we do kernel stack tracing in NMI context all the time with no issue
(but I mostly work on x86).

> 
> Per my understanding, stack trace unwinding is not safe/valid to do on
> architectures where the NMI context does not have its own stack. But I

Hmm, no, I think it's fine to do it on archs where NMI doesn't have its own
stack. It works on 32bit x86, where the NMI shares the kernel stack.

Which architecture had an issue with a stack trace?

-- Steve


> could stand corrected, hence I marked this as an RFT.  It is safe to do
> on 64-bit x86, but not on 32-bit x86 and other same-stack architectures.
> 
> If we feel that this is not an issue, then that is fine with me (and
> sorry for the noise), but I just wanted to raise it anyway just in case.
> Sooner or later someone running scx on an odd architecture might
> complaint.


