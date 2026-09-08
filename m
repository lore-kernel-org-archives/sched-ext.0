Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD50E59B68A;
	Tue,  8 Sep 2026 18:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788890706; cv=none; b=suX6bgM0VJf3T6Ekyg1bIS94YU1V2VeptbUv+eWwT/3GIW6Up9GzHEX6FsQLWKJqwJi2fMWiQLmP5PZvH5FcQI7vSmZfd0f6eiALa7xbef0LF+wfwW2VpCWXQNPXlI+lIC0FKiyUTDT2tAKQ2laIB83MCp258d0mWRhqFBeutSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788890706; c=relaxed/simple;
	bh=+izvuhEto/rqxeDKdYSqynpvH9Sk7+k/IJJ1b6pN4dc=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=duH1YzE1Cm75dKOUc8HE7s8mmd++LZo5HteiEJ6vCvgj28JjX7VUGigNtTcgfPFbk9rVD7Kkh7XMVkCKzPrj/zVzpxVqFk9nzhOzKwE5f4xDhQfGo54+27RLZhCshq7UL9WlZ1HvPQYCIRw6Xcfl3us+ONv53rSBt6HZhglbU9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CjVMB+av; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CjVMB+av"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FE301F00A3A;
	Tue,  8 Sep 2026 18:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788890704;
	bh=yrCpXGcoydJmpbJVtpIANkua0JB5sKTWmN4rMBY1Ylk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CjVMB+av9KBTheJLRA1WjsqdJCb4E2SAzpbgHvd5ayvv10Ji4fxps7KLwcjZR8I2o
	 tVvdQUewGa0FjXuDDksONWmvISR5Fgxcd641bWDy6OQQpRI0rdY+Rp3NjJIQYzisVi
	 /fwFsjy4muRz0HeePJeDNtXfqDowNIMOLOPKoSOPejQCNSplnOp1WisiMQOZPUSESa
	 Yez9rn61M8/wYKthSPZmE1msx4RHATxo7eriUJ1UokASefLAPesKfyzM1F+BSM0t2q
	 9/0yIOv+EnpTgzjhFOhy6k2OfDHwzkK4YsUi3QYgCh3GXvT5w8kNTBdB0qzDvgno5x
	 j8Uyvah+V872w==
Message-ID: <47ce114f204b0c2f630bcdb2900cd5b0@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Tianyi Chen <hi@tychen.cc>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>,
 Shuah Khan <shuah@kernel.org>, sched-ext@lists.linux.dev,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Emil Tsalapatis <emil@etsalapatis.com>
Subject: Re: [PATCH] selftests/sched_ext: Handle CPU hotplug write failures
Date: Tue, 08 Sep 2026 08:01:34 -1000
In-Reply-To: <20260906135534.749534-1-hi@tychen.cc>
References: <20260906135534.749534-1-hi@tychen.cc>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hello, Tianyi.

Applied to sched_ext/for-7.4.

Thanks.
-- 
tejun
