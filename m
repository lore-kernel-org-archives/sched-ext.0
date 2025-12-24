Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6690A34B185
	for <sched-ext@lists.linux.dev>; Wed, 24 Dec 2025 14:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766585830; cv=none; b=g1JgX1h8ebbU01Elq5Z3QitnHmEd7gae3wuWccyD9gGLUkeNArN/Yma/MXPZdCt7UogCWkG9jEyvU+bqAkb9S6HTDVVdbBfn9BftD20VjMdWlZyRi32fAPuyFCo4FS9WjV1mYw8HhKJUmTWiLNMTq5EisyR/faiJQDJNLxJZf9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766585830; c=relaxed/simple;
	bh=cpSDde5HginWe0gLZqUwKe8HMV5Kx1G7wAVAVm6mzFA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=piigNLE//LijWAJ/+Y6btPyu7zEgOWlFmTDw3Z9qCaVg4ziEuIzlk5DLWmfEVysWhnmlBJhK93/CZGsUlE1IIHKru+zmR//vYcv2A7BpigbkiiOPvUNhHrNUk/50LLuP3z80GOBOjLJ2CEbt+0lTYbi1uzVR4qKj5M+ZWlWPZSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf05.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 0FBEA13A249;
	Wed, 24 Dec 2025 14:16:57 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf05.hostedemail.com (Postfix) with ESMTPA id 012E020015;
	Wed, 24 Dec 2025 14:16:53 +0000 (UTC)
Date: Wed, 24 Dec 2025 09:18:46 -0500
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
Message-ID: <20251224091846.3851271a@gandalf.local.home>
In-Reply-To: <20251223235833.GA1273740@joelbox2>
References: <20251223005038.62406-1-joelagnelf@nvidia.com>
	<aUoCBVhHig737uKt@slm.duckdns.org>
	<9D417792-A0A8-44C4-884B-A3406D2E7A1D@nvidia.com>
	<20251223153136.761d99af@gandalf.local.home>
	<20251223235833.GA1273740@joelbox2>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Stat-Signature: yjzi17xzbpazokbcb8cyronny8rzyqs7
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 012E020015
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX189+mzrjKhQtziyqU/XJ3R0bl8E1S80FFI=
X-HE-Tag: 1766585813-388980
X-HE-Meta: U2FsdGVkX186nTNAXSXZpql1LaRuCakujmAq30OWiC3yzKQHnDHUauKtaHwY32S6nzFF+zmzQG1tFKo86FxbgW0fV4Epe+kXIKlnFHGZRbpSDnN7mC9ODrRnU99XhZENIWhDYPG8VFQNxVqBvhJaYuZgL+mDzZMUGo1XPI6CXxnqPwaduai0dT7V1OaTGt+2+WkB4T5NvQEfFRvHaGs6CMogKarIc/fkPJkCq590/qcJ0HDR18W+bPLfHg2+vm71f4dVF/1B5A5XBWgFUW7BCijys2LCPL9M+xSnk+pwy9zJs6P/6EhM4vp5kX8j3igml076lGTIku2SqNpYQp9Ckcx/FW6eP1Xs

On Tue, 23 Dec 2025 18:58:33 -0500
Joel Fernandes <joelagnelf@nvidia.com> wrote:

> Some documentation suggests IST is required for reliable NMI stack tracing
> [1] [2] which 32-bit does not have.
> =E2=80=9DIf an interrupt or other exception is taken while the stack or o=
ther unwind
> state is in an inconsistent state, it may not be possible to reliably unw=
ind,
> and it may not be possible to identify whether such unwinding will be
> reliable. See below for examples.=E2=80=9C
>=20
> Probably the issue happens to be more of printing garbage than crashing t=
he
> kernel, but I am not convinced it is stable. Hmm.

Correct. It's about reliable stack traces, as live kernel patching requires
that the stack it looks at is reliable before it can modify the code. What
happens if it's not reliable, means it will just stop at the interrupt
handler and you don't get to see the rest (or you'll see a bunch of
functions with "?" in front of them).

-- Steve
