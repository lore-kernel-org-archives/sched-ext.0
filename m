Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5D4271464
	for <sched-ext@lists.linux.dev>; Mon,  2 Feb 2026 16:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770049403; cv=none; b=O+LIGsaIe4/h9/zFhBeljul4jq1W7mNBNdWZHufdEVUz3K/lvE59pKQ43xGWAPaXai1zv7+DRHCeXiJy+NxyLVBNjDlsj56ClLRtKCFQfL3eYBoavdJK2kio//51Q+2ks9kyUNu26S/T6vAkEcb6ADg+YKchW2KvkGcW5s3UQN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770049403; c=relaxed/simple;
	bh=pQZoT6Y4K8pKVEJCNefkiWvGdDfj0p/SjpdkYyfs4J0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ctWj/DMXCIkS30OXtVPbKvMiMETal7dTMii8iE93aZqNNkWNpTxfQ1rHHyeuCRUD1zDksuo1FgXMsHXnBamXLMVCEedxBisqkFWHB+vxQ+qVR7CAlYdQq0F9BFgiLGZp6j8DZlMYVtOyQuGSxuaptV4FXNjlButvyCWqkDasIM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TDe6Ekdr; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TDe6Ekdr"
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-430ffc4dc83so4850629f8f.3
        for <sched-ext@lists.linux.dev>; Mon, 02 Feb 2026 08:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770049400; x=1770654200; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1Gwk8eQ5wUeRhu8FK4dC5BwQ5ED+3LlOf9MmormlXz8=;
        b=TDe6Ekdr4Va8Fu8o2ZOnE4RWBzCrXqQO1uhzcFk74nWzuYbSnLySJlLf9F8hscw/1p
         ClU0HEUi6DczbzUKQWhvwjcSmXt4rLcA+WNxh/rlW7A2g4/cYbzrnDi4hzoK8F3j5qds
         5lzBjAeziHZkVY0ysi7i0BMS1mCTfOSX6vnJTGuNPXZUcdrgbWeJOrrYPyxnM4MpQ8WH
         blRBgBj1zvGEDc+F7Mjx9tjEs130drtMRYp/1Al+9ORRZBgMv+Q4s92kZzv3BiL9EPOc
         9JNMoY3lTv6zuIQQiyay9WzmemF+Ig2zgr14gwJmQhjQC3/1nCsvL9TnEIQSrxtOscuN
         shCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770049400; x=1770654200;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Gwk8eQ5wUeRhu8FK4dC5BwQ5ED+3LlOf9MmormlXz8=;
        b=ZhUq0yR6fWQ/CI0bEdbPFacqGl304OG5PmgH9Op+EMzvN/1I9IgUjApqpM+XIEk03Y
         5ocE3Vkw+EOGOzViGP7jOfWJtvA4VOKbbJED+wIIy9Fe2Hk8/DaKjgGUuQzFoXMXR4au
         QQ173EYNbEZzR5P4ZhvfhK2D9uVIEF1+qen6BURkdLg2s1zER9uaM7TsDipSHJaeuRa3
         kp/a26VTQU8IqIkftPySxwwOAsX3TbUg0UlHeQ68uL9m1+UVsBrvVUI6UFpe2bnNGRY8
         0QN0RINau0e8xkUd9KoqORC+F6k6vXmC1CHOEEg4Gm80vFKZ0DknuD26NWQXpf/oCY3O
         6fXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVq+erEFDKy6rVuFtZwPb5XPj5fDoy1+Kujf9v8vzJDz8zWOqGrz0zkLAem2BSArZ5Exr6IbULeRtM=@lists.linux.dev
X-Gm-Message-State: AOJu0YxeVj4CZ+6FY3aGkKAfRYAcwBlJB5hKxU+0UnbiNhv4jH3gMWa1
	rjQ5YlwXEpdDGcNoed/YsOfQPdOw5gUZ8xE1Dr7ZQvfWuq50ot3kFhBRNdNg/xrFeaGpxsgD3br
	I0DRKm1u3LLGjfg==
X-Received: from wrm4.prod.google.com ([2002:a05:6000:26c4:b0:435:99e6:7da6])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:26cc:b0:435:953e:589c with SMTP id ffacd0b85a97d-435f3aaa43bmr16885535f8f.34.1770049400431;
 Mon, 02 Feb 2026 08:23:20 -0800 (PST)
Date: Mon, 02 Feb 2026 16:23:19 +0000
In-Reply-To: <aYDIRQkwstFxPleQ@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260126084258.3798129-1-arighi@nvidia.com> <20260126084258.3798129-2-arighi@nvidia.com>
 <aXp9xSpYhaysBLQ2@slm.duckdns.org> <DG1WJEB6B0AC.151EBIUYXCR55@google.com>
 <aX-QxWngrRcOj3PT@slm.duckdns.org> <aYDIRQkwstFxPleQ@gpd4>
X-Mailer: aerc 0.21.0-0-g5549850facc2
Message-ID: <DG4M58LNKUDN.25DQ0F32RBI92@google.com>
Subject: Re: [PATCH 1/2] sched_ext: Fix ops.dequeue() semantics
From: Kuba Piecuch <jpiecuch@google.com>
To: Andrea Righi <arighi@nvidia.com>, Tejun Heo <tj@kernel.org>
Cc: Kuba Piecuch <jpiecuch@google.com>, David Vernet <void@manifault.com>, 
	Changwoo Min <changwoo@igalia.com>, Christian Loehle <christian.loehle@arm.com>, 
	Daniel Hodges <hodgesd@meta.com>, <sched-ext@lists.linux.dev>, 
	<linux-kernel@vger.kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>
Content-Type: text/plain; charset="UTF-8"

On Mon Feb 2, 2026 at 3:52 PM UTC, Andrea Righi wrote:
> On Sun, Feb 01, 2026 at 07:43:33AM -1000, Tejun Heo wrote:
>> On Fri, Jan 30, 2026 at 11:54:00AM +0000, Kuba Piecuch wrote:
>> > Is "local" short for "local or global", i.e. not user-created?
>> 
>> Yes, maybe it'd be useful to come up with a terminology for them. e.g.
>> terminal - once a task reaches a terminal DSQ, the only way that the BPF
>> scheduler can affect the task is by triggering re-enqueue (although we don't
>> yet support reenqueueing global DSQs).
>
> I like "terminal DSQ", if there's no objection I'll update the
> documentation using this terminology.

"Built-in" would also work and avoids introducing new terminology, but it
doesn't provide any insight into why these DSQs are special, whereas
"terminal" suggests there's some finality to inserting a task there.

I'm slightly leaning towards "terminal".

Thanks,
Kuba
