Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2947330F921;
	Fri, 28 Nov 2025 13:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764337006; cv=none; b=CnE+tWbdvl53QoV6dUvHeED0NwqXFbrg/DZwLtCfAuiiGIrKuZurP5pXUD2bNRdKn89Ou0QvZ4DT2zHfszx8rJozKlpMp7axIBldzv8qaB52xFrfrFe/hADu+vFg/V0POqOZs3HQ8bK1UcF9qCVT2J8w0+Hs+YTEQ8ZOkzCEPcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764337006; c=relaxed/simple;
	bh=LZmqu7JgExM16VEVRp9sYyZhZTh8hAMeHyhfYjal1rM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bUIssKsHF3U/UDZA/H9l8yBvy3fEgZT1bdtk2dpt9C+PDGAG/2beFEOebHLmzHkjNoDIKHJ1egbY9rE47JX+mRglygfTVD5Hm+de+F2ZLUR/qwrI1wD/9z676Za+QmSOWILMrnckU2n3eaAzuW3JNCmrfhA8fY2Q/6u+zOEQhBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HlXKTx/4; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HlXKTx/4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=LaiOrZbyFftAVyJ5K5P1XZpyXJeZTNn3aBGEo0YaICY=; b=HlXKTx/4mTZm6ay2B68bi8kBz/
	iucR45QW64vAG82nAIaacZipqEgII5efnjK0/3bKvC8wqofLfM//dsjZfjvoPY17oNzjiM69xABSb
	btMMmngU2C0xu41pHYugeGnvHU+KtfvriNt5UzdbBxu7D/jx7IK9uLedRd/pmy8ZeG9AhYlCdw8KL
	gneZbd3eWCTGIUy5e5EXdPKR1UjmwP+Q96X6yznuan0jpmD85D67oXaYQR/3BMmVwkcuY9o+79wZb
	O4vYa5x4YAyRtH2qY7Iy91Hg8vI/JvQJ0L3WWbssNcU5efwxv/vHEvtQdWUR9htRBgWH+Q8TU9eLH
	KTLvjedA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOxmn-0000000Bynp-0tqz;
	Fri, 28 Nov 2025 12:41:17 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 526E5300325; Fri, 28 Nov 2025 14:36:38 +0100 (CET)
Date: Fri, 28 Nov 2025 14:36:38 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Kuba Piecuch <jpiecuch@google.com>
Cc: mingo@kernel.org, vincent.guittot@linaro.org,
	linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, tj@kernel.org,
	void@manifault.com, arighi@nvidia.com, changwoo@igalia.com,
	sched-ext@lists.linux.dev
Subject: Re: [PATCH 5/5] sched: Rework sched_class::wakeup_preempt() and
 rq_modified_*()
Message-ID: <20251128133638.GA4067720@noisy.programming.kicks-ass.net>
References: <20251127153943.696191429@infradead.org>
 <20251127154725.901391274@infradead.org>
 <DEKD1W6CI6UJ.3TWR30PXQCF8O@google.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DEKD1W6CI6UJ.3TWR30PXQCF8O@google.com>

On Fri, Nov 28, 2025 at 01:26:30PM +0000, Kuba Piecuch wrote:
> Hi Peter,
> 
> On Thu Nov 27, 2025 at 3:39 PM UTC, Peter Zijlstra wrote:
> > Additionally have set_next_task() re-set the value to the current class.
> 
> I don't see this part reflected in the patch. Is something missing?

Hmm, that does appear to have gone walk-about :/
