Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CB63AE6E2;
	Wed, 25 Feb 2026 17:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772039327; cv=none; b=ShWARCU3Ssw+B5NctWnEPJMsglDNraRLgnwEDaU+jLGPphPa9yIj30YF5lkpg9bvqKiC16d4btSUv60MaLvXEL6PTlo5csFfN8vbPnENdxqVvuBDMwDTcVJ703drRPSza+xiUGOwvIMNO6BAYiscDM8z38hjFMFeqFvkQK/zhnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772039327; c=relaxed/simple;
	bh=pGtTBQnQK9No8Ed6an3som6tWGLbWjpgFUGeWJ+BLFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZNtdtst+OiW9fDjsOoYyazoR1oXt6bDPKkLgqVFa/xl0v+0XCYw4fvD5kRrbqy/ChmAW8g1VAI+IHIdPl33jdDZOrLNCDrooSTeQSowUv+mqBPvy0eIIu+B+lcL9+qh/+OztxCH9za3f6faCqSm6MIo6KLMDdN5o3wfQwKv+bE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jo+rq19+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jo+rq19+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF96CC116D0;
	Wed, 25 Feb 2026 17:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772039327;
	bh=pGtTBQnQK9No8Ed6an3som6tWGLbWjpgFUGeWJ+BLFk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jo+rq19+KP55mHGeJkdYGeSNBHbP5nPM797iC4k6/7/QY1rh0u3WN/Tjb/SPff0W/
	 wO8DTsfUrm9iLvNZ384BvcN5R1LqSrZe1+2P/yuo4IuMiAp63OyNYXA5otd7KChsU+
	 A5NizHsu9/WSnck/aaSGKSV55UtC1LHddumfoOMRay9HU5QiLPW3Bx9ldR7wK0Ty8V
	 UCL3VmwGstGUX0yllhF2+7gHUi2w70OdS9u5GcQQr6CVoCTdYRA9mdZHJl9PPcOGdh
	 o+cTbpP/6J9WPFgZFsLCwh3GabobkUbzLt0KBZx9t/JjZOYmNGON0J3SM55IGNCBbe
	 QKht+aCVDPA0Q==
Date: Wed, 25 Feb 2026 07:08:45 -1000
From: Tejun Heo <tj@kernel.org>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, Andrea Righi <arighi@nvidia.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Nam Cao <namcao@linutronix.de>, Juri Lelli <jlelli@redhat.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>, sched-ext@lists.linux.dev,
	Tomas Glozar <tglozar@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v6 14/16] sched_ext: Export task_is_scx_enabled() for
 verification
Message-ID: <aZ8snSHWw-U0lVz2@slm.duckdns.org>
References: <20260225095122.80683-1-gmonaco@redhat.com>
 <20260225095122.80683-15-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225095122.80683-15-gmonaco@redhat.com>

On Wed, Feb 25, 2026 at 10:51:20AM +0100, Gabriele Monaco wrote:
> When a sched_ext scheduler is loaded, depending on the configuration, it
> can handle also fair tasks, however it isn't trivial to understand if a
> certain task is currently handled by fair or ext outside of scheduler
> code. This can be a problem when writing verification or observability
> tools like RV monitors.
> 
> Export a task_is_scx_enabled() to allow quick classification by using
> the scx state SCX_TASK_ENABLED.

This test already exists - task_on_scx(). Please feel free to move that out
to include/linux/sched/ext.h.

Thanks.

-- 
tejun
