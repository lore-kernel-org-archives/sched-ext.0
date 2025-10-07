Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4353C2556E
	for <sched-ext@lists.linux.dev>; Tue,  7 Oct 2025 13:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759844145; cv=none; b=bskkSjG7gcsR4m27T2cBkZWhb+ZPAP9lg1Ovx1rFL9wM+bBDx7TuoAN5ocJ9nGqFjALoNj0pshgg026SOSOA7867Rmkt0Pr+SfBvRi5MpIrrLXQl+THdJJNv85T8GTk9wGNwBTgNU77reAM25M+PZpo+pJFo2i3iezxjMKnU1TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759844145; c=relaxed/simple;
	bh=Sr1TPKrDNiNd8gjcbvJFYIP/F0PQhjlDUSHSQ0/L4JQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=OrJuYGBaDkhx0rLYf9XSwluu84RIXLebnY8jbCNnkdZrMvbCYgPxNE1HTlQq1ND/G4FTE3KgfH+ekc76ciMU5MSAFLDRHH2UQgKTNoMnFsUX++14IDDsEnWbpWMtL7lWkaNE2MkVIJtHWZYIw/M1AHIXtJhLA/R0YwjiFNhZh0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cLpQJ2FH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cLpQJ2FH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759844143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=k6v7yb1rl15Twn4dkD0T9EGYlX+SypOExz5YLkOMv/E=;
	b=cLpQJ2FHkaPrPnpQDoGg9azuYPXaTHTVUBUsTBr+0HYntKXLIxdWu6fecKmafQZuNNHWUJ
	Ge8uIyrF8exT0wyNtSGjrHiw+sbrUSQOOTpExv5NrGbfewqV4Q9Dc+CyXjsrRtra3OwSuY
	S6D9Hk6yxp1hFo97orTuTqXZyc7a+sQ=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-193-vefcZLoWMeao5cLirpYe4w-1; Tue,
 07 Oct 2025 09:35:40 -0400
X-MC-Unique: vefcZLoWMeao5cLirpYe4w-1
X-Mimecast-MFC-AGG-ID: vefcZLoWMeao5cLirpYe4w_1759844137
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 67D111956096;
	Tue,  7 Oct 2025 13:35:31 +0000 (UTC)
Received: from pauld.westford.csb (unknown [10.44.33.36])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 057C730002CE;
	Tue,  7 Oct 2025 13:35:27 +0000 (UTC)
Date: Tue, 7 Oct 2025 09:35:23 -0400
From: Phil Auld <pauld@redhat.com>
To: Andrea Righi <arighi@nvidia.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev,
	pauld@redhat.com
Subject: sched_ext and large cpu counts
Message-ID: <20251007133523.GA93086@pauld.westford.csb>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: mqHeV2A4gWh3VadxjB-ir7_CZBAgsMPp2yWlBCCuJ2A_1759844137
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Andrea (and other sched_ext folks),

I've got some partners with systems with > 4096 cpus. On those systems
sched_ext crashes at boot due to:

init_sched_ext_class() {
...
        scx_kick_cpus_pnt_seqs =
                __alloc_percpu(sizeof(scx_kick_cpus_pnt_seqs[0]) * nr_cpu_ids,
                               __alignof__(scx_kick_cpus_pnt_seqs[0]));
        BUG_ON(!scx_kick_cpus_pnt_seqs);
...

4096 * 8 bytes is 32768 and is the max you can precpu allocate.  Anything more
and the _alloc_percpu fails and WARNs

[    0.000000] illegal size (33792) or align (8) for percpu allocation
[    0.000000] WARNING: CPU: 0 PID: 0 at mm/percpu.c:1779 pcpu_alloc_noprof+0x715/0x820

I started looking into changing that to static which would have to be based on
NR_CPUS (8192 in our case).  Because it's N^2 that starts to be a lot space.

While looking at how it's used I had a different question.  The comment says

  * We busy-wait here to guarantee that no other task can
                         * be scheduled on our core before the target CPU has
                         * entered the resched path.

But pnt_seq is actually only updated if we enter the resched path AND switch
classes. That seems more restrictive that the comment seems to require, no?

Any ideas on how to do this in different way?

I'd rather not have to turn off the CONFIG but 512 MB is a lot of space to
allocate for this. 

Thanks for taking a look and any suggestions.

Cheers,
Phil

-- 

