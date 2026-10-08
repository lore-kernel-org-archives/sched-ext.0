Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92B23C3F64
	for <sched-ext@lists.linux.dev>; Thu,  8 Oct 2026 19:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791486805; cv=none; b=mkrnpzQNENYiuKNWSpDP3SlHKlvPNdGEKLuy+PeQ43OpJ8i8XuONUhWIvx5G2gVR5Tm8J6qHzxxr2y9ilbvtIlpbl/U9cnYSsKvqLefRfpU9ABLU+mCixXdtmu8qg0xue/q3tAZw0OX+0TJsiWJzaEmNTVRzztc979dAR/A8f0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791486805; c=relaxed/simple;
	bh=Gns521/EKZLdx7MAed51/yhfAPJrg46pDNraWUEqGY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BLYsAHA8XYGuHZl7hd6I11dCzXABHfGOzGp4M4FUTeWt/z0aASP5K3bBMQgs0mFUTTjEglhm40Gf1daj1VPS2aiGeHnu16wGv65sf8XvC7Jvh4w9xTlq8AE8boYoXywFOiwt2754P7ZXwjDD/bumpUIXI3SC2+2JIef0zWvFHjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R+tuIJxj; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R+tuIJxj"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48b0f063b7bso143000f8f.1
        for <sched-ext@lists.linux.dev>; Thu, 08 Oct 2026 12:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791486802; x=1792091602; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NsKnBLI7Oap+/MtZR28XECViUHg4ECBk5FTj278RiYo=;
        b=R+tuIJxjcXP89AFRXhYn0nTN7ha3+MfmSpPMZqR8qs/zmalzT4yf3MRgdspn/2yu9o
         yJ6mqy//ZsUZhd8XIUbEoHRYsh8RTnUDilYT/5nP+xHCZ0OXwBDLmFkC7ibSGT8FiohJ
         heC+KGft87QXYMQhWhsEHD+Ua6Xs9Ty1tuKAPWEEVqf+us4t2+s3Y4LkClk2Qy1lUhum
         Vn0GQVfnRLTaOhmqKIwVKU26AWfcqvZlx5IS5Yk/QpEqyR2cfUJ0tjUNMIPO8d2r+lT6
         92qxBIbeeIys0hksXx3hYotnFs1caMxvvLdr3v0TztnqWCO984ezIQe1KMSV2xM30PJL
         PWyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791486802; x=1792091602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NsKnBLI7Oap+/MtZR28XECViUHg4ECBk5FTj278RiYo=;
        b=fcqOAJFglPVP8BWwkMlHP5BC/qDQB9wCEXHhlGsuCaWcvxdhTOcN4l4tWTKF0fGsob
         M0CwYgvOZaC2lVOGbeq9BRcfsHvis1rbJ3CfMbogwxIBGAe6SYybhEwJq7pXd+Wld3DI
         iCvGJWJtg+lt9pGSmPIwtWydpB2tvwPJBp/Tr347b7OzGNbTwXrEBkGXWIqhIFWgRMbA
         zTRgzTt6Lj8gHHLVCuToCSq4HZKXEkiI9DvFoCQiUy4ecNunWDJ+1yYChzYanLwopWAe
         /5HQPaeNUotZvRZruW7lvqfNbM2COpd3D1MrwA/XaadrVZrshrMLQbms78AS1neYoUDH
         nbnw==
X-Forwarded-Encrypted: i=1; AKwUvBxRpxc9+qHs6ljm08aJr1OqziJY0mVXP77iiNX39fN7uPOLCLzTLdgKjLpVM5Us0MSq9YnKqIZxx/w=@lists.linux.dev
X-Gm-Message-State: AFq9FYKLRWuEWXii8Of7gzsaMYZ97toFgzwIZzpH960cYqXRcobNM1zY
	8CtyQ4sgN/+fdh3A4MYl5LCZ+RjrrpiM80FRdDTrbUVl8X6RZWpaTlPY
X-Gm-Gg: AYBFou2FkspHSdZivwl9zKOizTio1peWi2lpIuFvO7HOi1sXd4aXIIhqxvIGdkZktEB
	flP+q7DwLK3yfw4kivF3gihr3gnGd5flcGBoiWGcJrPS70ZB2MYyc8SRHRmjajDKDoFEKJOApG2
	OWfZ18g2crURQ+8povdCqE/LiZN3vrJnQoU77rWBGsDESZUlJCsnTeP8NWEJM1OEWQZZfYJ7Xho
	lt2m08959xT97muBMcaCLCxe4pQ+XhKR5FliZRqZivw//6Aey5s5W/XzTXQERHpZwgxBzRacKdO
	bCNvgQDmzIY9UNU3m7Npf3u+GvyeLzsWnM8jtIGAEjxjQWdGGnLr6U40/cUpiXR1fxjq3HkMYpN
	HIzzZPXo1mq40Yt/i+Ryos/j5/hZtGLklwmnQtVPheAUdMXJhcezOMI7baNZR4rQTbF05q4WStr
	I6xS85wSWVtx9XCR0CY5uT9mozWnTrmG4SpKy4IZ4cyvYgOAn+FJV33P1dnrZgyd+dOnAXk4rYI
	3h2RQU55MX78OzOTcXrYCP4699EW9M=
X-Received: by 2002:a05:6000:38c:b0:48a:f4c1:4301 with SMTP id ffacd0b85a97d-48c7edcd161mr6378457f8f.6.1791486801862;
        Thu, 08 Oct 2026 12:13:21 -0700 (PDT)
Received: from lima-kdev.local ([85.100.66.184])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48db652e52asm1158763f8f.36.2026.10.08.12.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 12:13:21 -0700 (PDT)
From: Kayra Cizmeci <kayracizmeci@gmail.com>
To: vincent.guittot@linaro.org
Cc: arighi@nvidia.com,
	bsegall@google.com,
	changwoo@igalia.com,
	christian.loehle@arm.com,
	dietmar.eggemann@arm.com,
	juri.lelli@redhat.com,
	kprateek.nayak@amd.com,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	lukasz.luba@arm.com,
	mgorman@suse.de,
	mingo@redhat.com,
	peterz@infradead.org,
	pierre.gondois@arm.com,
	qyousef@layalina.io,
	rafael@kernel.org,
	rostedt@goodmis.org,
	sched-ext@lists.linux.dev,
	sshegde@linux.ibm.com,
	tj@kernel.org,
	void@manifault.com,
	vschneid@redhat.com,
	Kayra Cizmeci <kayracizmeci@gmail.com>
Subject: Re: [PATCH 00/18 v2] Improving latency of short slice tasks
Date: Thu,  8 Oct 2026 22:12:36 +0300
Message-ID: <20261008191236.152916-1-kayracizmeci@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261002154415.2270586-1-vincent.guittot@linaro.org>
References: <20261002154415.2270586-1-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi All,

I wanted to ran some tests for this patch series. I couldn't really
apply it without some issues, but I think I managed to apply
it cleanly this time... Tho I may have been doing something wrong.
Please let me know if so.

base: 4a3b51aab6e25244d97936aa65e6d5425adf98e1 (on tip/sched/core)

Command Used Each Run:

hackbench -g 4 -l 100000 > /dev/null & sudo chrt -o -T 300000 0 ~/rt-tests/cyclictest --policy=other -t 1 -i 1000 -D 20 -q -m; wait

Environment:

Zen 3 with 8 Cores and 16 Threads. And Fedora.

THE RESULTS (COOKED):

On Base in 5 runs, average values are: Min: 3.8, Act: 5.8, Avg: 8.8 and
Max: 2511.6 (I need tea.)

On Base + Patches in 5 runs, average values bla bla you get it:
Min 4, Act: 5.8, Avg: 7.2 and Max: 1781.6

Or, in the shape of art made with love and passion:

 +------BASE-----+--PATCHED--+
 | MIN   3.8     |    4      |
 | ACT   5.8     |   5.8     |
 | AVG   8.8     |   7.2     |
 | MAX  2511.6   |  1781.6   |
 +--------------+------------+ 

Hmhp... Hope I'm not missing something. I need water. Bah.

Tested-by: Kayra Cizmeci <kayracizmeci@gmail.com>

Dancing donkey chases a car while shouting "Linux is the best, my dancing is the coolest. Cry."

Thanks,
Kayra



I'll add other not too important things below, these are pretty raw.
But if you wanna have a look you can.


THE RESULTS (RAW):

BASE 7.3.0-rc1+ #2:

RUN 1:
[1] 1950
# /dev/cpu_dma_latency set to 0us
T: 0 ( 2115) P: 0 I:1000 C:  19990 Min:      4 Act:    6 Avg:    8 Max:    1885
[1]+  Done                       hackbench -g 4 -l 100000 > /dev/null

RUN 2:
[1] 2132
# /dev/cpu_dma_latency set to 0us
T: 0 ( 2297) P: 0 I:1000 C:  19990 Min:      4 Act:    6 Avg:    9 Max:    2695
[1]+  Done                       hackbench -g 4 -l 100000 > /dev/null

linuxfucks@micro-softly:~$ (Opsies. Who's hostname is this? It's so cool. Wow. 'linuxfucks')

RUN 3: 
[1] 2307
# /dev/cpu_dma_latency set to 0us
T: 0 ( 2472) P: 0 I:1000 C:  19988 Min:      4 Act:    5 Avg:    8 Max:    3246
[1]+  Done                       hackbench -g 4 -l 100000 > /dev/null

RUN 4:
[1] 2493
# /dev/cpu_dma_latency set to 0us
T: 0 ( 2658) P: 0 I:1000 C:  19995 Min:      3 Act:    6 Avg:    9 Max:    1991
[1]+  Done                       hackbench -g 4 -l 100000 > /dev/null

RUN 5:
[1] 2671
# /dev/cpu_dma_latency set to 0us
T: 0 ( 2836) P: 0 I:1000 C:  19992 Min:      4 Act:    6 Avg:   10 Max:    2741
[1]+  Done                       hackbench -g 4 -l 100000 > /dev/null

BASE + PATCHES 7.3.0-rc1+ #3:

RUN 1:
[1] 1490
# /dev/cpu_dma_latency set to 0us
T: 0 ( 1657) P: 0 I:1000 C:  19993 Min:      4 Act:    5 Avg:    7 Max:    3091
[1]+  Done                       hackbench -g 4 -l 100000 > /dev/null

RUN 2:
[1] 1671
# /dev/cpu_dma_latency set to 0us
T: 0 ( 1836) P: 0 I:1000 C:  19999 Min:      4 Act:    6 Avg:    7 Max:    1529
[1]+  Done                       hackbench -g 4 -l 100000 > /dev/null

RUN 3:
[1] 1848
# /dev/cpu_dma_latency set to 0us
T: 0 ( 2013) P: 0 I:1000 C:  19998 Min:      4 Act:    6 Avg:    7 Max:    1455
[1]+  Done                       hackbench -g 4 -l 100000 > /dev/null

RUN 4:
[1] 2023
# /dev/cpu_dma_latency set to 0us
T: 0 ( 2188) P: 0 I:1000 C:  19995 Min:      4 Act:    6 Avg:    7 Max:    1524
[1]+  Done                       hackbench -g 4 -l 100000 > /dev/null

RUN 5:
[1] 2200
# /dev/cpu_dma_latency set to 0us
T: 0 ( 2365) P: 0 I:1000 C:  19989 Min:      4 Act:    6 Avg:    8 Max:    1309
[1]+  Done                       hackbench -g 4 -l 100000 > /dev/null



