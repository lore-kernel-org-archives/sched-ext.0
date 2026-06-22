Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA82347FC4
	for <sched-ext@lists.linux.dev>; Mon, 22 Jun 2026 19:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782155036; cv=none; b=oUyl4aUqsqJbmfwWlHwfhwmt3Q+g8m4oO4AAqlcCxN01PgaTZLBLofhbJETm1YmuG5fdes263RZxHLZjtaqBCoNst9xH5jFMxGPrUjtqHMbBbj2iHG9uu/KD5EPJ9wIpTECC9DcbhnqsbiPNfhE+ru409HPhQKl9I2/vod8gCoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782155036; c=relaxed/simple;
	bh=uM6rjwv+rWrcNEl8KjTKnVcDSG3oUNpsPUMqnFOcLeE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PdhP0mbb7Bt6kl/eOrcP/054iSE/N1T3otV7WefP3qpblwzbs6r0eoInL4pWnQ4N0l2/RsU2Rl9Xde+HiW5/cscOLm7KkDVyOu/dw7mJuQSiG7JHKg5mBdaGyis4utNUTe3jo+JEPCEPkekS1edQpO0XxTrhaTCRSx1QWV37lsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fVFsVndf; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fVFsVndf"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-3042a388168so186224eec.1
        for <sched-ext@lists.linux.dev>; Mon, 22 Jun 2026 12:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782155033; x=1782759833; darn=lists.linux.dev;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uM6rjwv+rWrcNEl8KjTKnVcDSG3oUNpsPUMqnFOcLeE=;
        b=fVFsVndfg6mWKVB5EXTVDBkJ3nNQyNSuuy0dvNOIt0yrFYWUAs5viJCJZ1+sJcyX8K
         44ipD6N+nptdUxD/Ihp50qXFW3QSSQdv+fsleMVC1msyBlvN69Jmughef5wEPgm40bAJ
         MX2334ApBK7egBKDzD4QulH9lIqvtoHdLJc60iFcByl7w3KpdGhTxie66aqY9Gbh8jC5
         ZvZL3QUIhb9tA1/Ge6wloUyhokLN7+TwfbMQSSZmiSQaowX7cp+oHXhk7Vcway66c1nU
         2JKRUM1UF6dTin9s33bsTKC5EAwnJXaUl1HNBhR+Mxw4NE2ZBTWOWK5PB4UkawodUDI8
         GJ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782155033; x=1782759833;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uM6rjwv+rWrcNEl8KjTKnVcDSG3oUNpsPUMqnFOcLeE=;
        b=MlYB3HxCcjcCPCQd6dHYNbP3CyXVrf3/TyxcZ2dLx3FphydYynpsrwxiwKtSpSHRDQ
         63H1Ut2iy5Qh8a4Kgrr2VyfPF9jw/WlgnRuuC0vWep55r5RTkpc+0BUPrRvZdBcY5PoN
         Gis5+ccjv3cyk5YyCihXaxdE9s64klSJRHlPtRKmTreiXXJVeVdrxk8QbXvnELmwG8S+
         /iYdVDzh+ey1c3uHDVSp5SxQLpEokGPZKoyM94OZcwVXSHzobL2WPbPx0mo/6rfFaVF/
         CkJMss8zI4ooo92/GS5Kwm2XJb66YgHrS2yOwQnyaSFgiMWfJhfh+isQ1ME2VKLyV4fk
         kvAA==
X-Forwarded-Encrypted: i=1; AHgh+Rq8UPJycc3E7WOoDYIz00zJ3C48SMnShUcjh2e3cbwzm2uwrD9hIUUeJXtYB1F8UraLYZTO6nvvQZg=@lists.linux.dev
X-Gm-Message-State: AOJu0YzevTqbd6EdlfHqK6aCAqvy2CCa14Tka5+k5bX4+acEzw6XTR/1
	JPHxGYG/6O08vHTvxxpSv+lBS0tsGbMaUarxsXmuPHQgeMeyuwLN8OwR
X-Gm-Gg: AfdE7ckXk2Qns8fhzdCERXdSijqMO6Qx2SMb7Smgf7IKy5WGSf/VobGzNVx48SA5fmR
	Nzvhlj1Oo/gE01xN/5ipaizmhQopjZ8i9GkvpgZO8qhj/qtRT3s21W9LofQKuVrKgoXdxu9FnGS
	vM6UkW08cyLXMa8iM4FYZla85yF7jFz8L7Yi43+Pm3VwqdEGxn5XVZn9FHahj4EBHBWyS8/wJo3
	qBhkKC3E13zyOyRzZ+nNLpsGSBJVQ3+dWVXFwCVlzt3/ETnfskOf082aCYilI7NC7tE+FSj1BVn
	chLdEsA2cq+k9O4uKvuUli/RFWfZD/RdU+RNCg2zGCdLZ2acvTRFBzSnivwPi3UBo1JPtEK6PT7
	wBd+Li48gUH4hy48zxu3WKZzslyTbIdkk6ngJbuDIhX/dfIlSl/pt+I2o/0bKPYO92ko1vxTSyg
	EkR0Kn0xgHRVf5OsSnbaJioLOBf0+Z+EG7F7xVJjjK6wCfh6kR4Ldfm8brPvWJsxJ7qWI=
X-Received: by 2002:a05:693c:2887:b0:30b:cc4e:6396 with SMTP id 5a478bee46e88-30c5553b105mr382073eec.7.1782155033135;
        Mon, 22 Jun 2026 12:03:53 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:6e2:c699:67c:63fe? ([2620:10d:c090:500::1:5387])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c1be4967fsm10549199eec.26.2026.06.22.12.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 12:03:52 -0700 (PDT)
Message-ID: <1979fc81ae7bdaabda8616cd9698a40ef8bbfaee.camel@gmail.com>
Subject: Re: [PATCH v3 5/7] kernel: Use mutable list iterators
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kaitao Cheng <kaitao.cheng@linux.dev>, Paul Moore <paul@paul-moore.com>,
  Eric Paris <eparis@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann	 <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, "David S.
 Miller" <davem@davemloft.net>, Jakub Kicinski	 <kuba@kernel.org>, Jesper
 Dangaard Brouer <hawk@kernel.org>, John Fastabend	
 <john.fastabend@gmail.com>, Tejun Heo <tj@kernel.org>, Johannes Weiner	
 <hannes@cmpxchg.org>, Michal =?ISO-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>, 
 Maarten Lankhorst	 <dev@lankhorst.se>, Maxime Ripard <mripard@kernel.org>,
 Natalie Vock	 <natalie.vock@gmx.de>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar	 <mingo@redhat.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim	 <namhyung@kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Oleg Nesterov	 <oleg@redhat.com>, Peter
 Oberparleiter <oberpar@linux.ibm.com>, Andrew Morton	
 <akpm@linux-foundation.org>, Baoquan He <baoquan.he@linux.dev>, Mike
 Rapoport	 <rppt@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pratyush Yadav	 <pratyush@kernel.org>, Naveen N Rao <naveen@kernel.org>,
 Josh Poimboeuf	 <jpoimboe@kernel.org>, Jiri Kosina <jikos@kernel.org>,
 Miroslav Benes	 <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>, Will
 Deacon <will@kernel.org>,  Boqun Feng <boqun@kernel.org>, Luis Chamberlain
 <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,  Daniel Gomez
 <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, Steffen
 Klassert	 <steffen.klassert@secunet.com>, Daniel Jordan
 <daniel.m.jordan@oracle.com>,  "Rafael J. Wysocki"	 <rafael@kernel.org>,
 Davidlohr Bueso <dave@stgolabs.net>, "Paul E. McKenney"	
 <paulmck@kernel.org>, Josh Triplett <josh@joshtriplett.org>, Frederic
 Weisbecker <frederic@kernel.org>, Neeraj Upadhyay
 <neeraj.upadhyay@kernel.org>, Joel Fernandes	 <joelagnelf@nvidia.com>,
 Uladzislau Rezki <urezki@gmail.com>, Juri Lelli	 <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, Kees Cook <kees@kernel.org>,
 Balbir Singh <bsingharora@gmail.com>, Anna-Maria Behnsen	
 <anna-maria@linutronix.de>, Thomas Gleixner <tglx@kernel.org>, John Stultz	
 <jstultz@google.com>, KP Singh <kpsingh@kernel.org>, Matt Bobrowski	
 <mattbobrowski@google.com>, Nathan Chancellor <nathan@kernel.org>, Martin
 KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>,  Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, David Vernet	 <void@manifault.com>, Steven
 Rostedt <rostedt@goodmis.org>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, 	netdev@vger.kernel.org, cgroups@vger.kernel.org,
 dri-devel@lists.freedesktop.org, 	linux-perf-users@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, 	kexec@lists.infradead.org,
 live-patching@vger.kernel.org, 	linux-modules@vger.kernel.org,
 linux-crypto@vger.kernel.org, 	linux-pm@vger.kernel.org,
 rcu@vger.kernel.org, sched-ext@lists.linux.dev, 	llvm@lists.linux.dev,
 Kaitao Cheng <chengkaitao@kylinos.cn>
Date: Mon, 22 Jun 2026 12:03:46 -0700
In-Reply-To: <20260622042811.31684-1-kaitao.cheng@linux.dev>
References: <20260622040533.29824-1-kaitao.cheng@linux.dev>
	 <20260622042811.31684-1-kaitao.cheng@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

On Mon, 2026-06-22 at 12:28 +0800, Kaitao Cheng wrote:
> From: Kaitao Cheng <chengkaitao@kylinos.cn>
>=20
> The safe list iteration helpers require callers to provide a temporary
> cursor even when the cursor is only used internally by the loop. This
> leaves many functions with otherwise unused variables whose only purpose
> is to satisfy the old iterator interface.
>=20
> Use the mutable list iteration helpers for those cases. The mutable
> helpers keep the same removal-safe traversal semantics, while allowing
> the temporary cursor to be internal to the macro when the caller does
> not need to observe it.
>=20
> Convert list, hlist and llist users under kernel/ where the temporary
> cursor is not used outside the iteration. Keep the explicit cursor form
> where the next entry is still needed by the surrounding code.
>=20
> No functional change intended.
>=20
> Signed-off-by: Kaitao Cheng <chengkaitao@kylinos.cn>
> ---

Beside the fact that this does not apply,
I don't see a reason why is this needed for BPF sub-tree.

[...]
